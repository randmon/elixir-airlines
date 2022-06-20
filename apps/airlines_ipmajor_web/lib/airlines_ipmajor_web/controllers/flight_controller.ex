defmodule AirlinesIpmajorWeb.FlightController do
  use AirlinesIpmajorWeb, :controller

  alias AirlinesIpmajor.FlightContext
  alias AirlinesIpmajor.FlightContext.Flight
  alias AirlinesIpmajor.AirportContext
  alias AirlinesIpmajor.TicketContext
  alias AirlinesIpmajor.TicketContext.Ticket
  alias AirlinesIpmajor.UserContext

  def index(conn, _params) do
    flights = FlightContext.list_flights()
    |> FlightContext.preload_flights_airports()

    render(conn, "index.html", flights: flights, page_title: "Flight overview")
  end

  def new(conn, _params) do
    changeset = FlightContext.change_flight(%Flight{})
    airports = AirportContext.list_airports()
    render(conn, "new.html", changeset: changeset, page_title: "New flight", airports: airports)
  end

  def create(conn, %{"flight" => flight_params}) do
    case FlightContext.create_flight(flight_params) do
      {:ok, _flight} ->
        conn
        |> put_flash(:info, "Flight created successfully.")
        |> redirect(to: Routes.flight_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        airports = AirportContext.list_airports()
        render(conn, "new.html", changeset: changeset, page_title: "Error creating flight", airports: airports)
    end
  end

  def show(conn, %{"id" => id}) do
    flight = FlightContext.get_flight(id)
    # Check if flight exists
    if flight == nil do
      conn
      |> put_flash(:error, "Flight with id #{id} does not exist.")
      |> redirect(to: Routes.flight_path(conn, :index))
    end
    flight = FlightContext.preload_flight_airports(flight)
    d_city = AirportContext.get_city!(flight.departure_airport.city_id) |> AirportContext.preload_city_country()
    a_city = AirportContext.get_city!(flight.arrival_airport.city_id) |> AirportContext.preload_city_country()

    render(conn, "show.html", flight: flight, page_title: "Flight #{flight.id}", departure_city: d_city, arrival_city: a_city)
  end

  def edit(conn, %{"id" => id}) do
    flight = FlightContext.get_flight!(id) |> FlightContext.preload_flight_airports()
    changeset = FlightContext.change_flight(flight)
    airports = AirportContext.list_airports()
    render(conn, "edit.html", flight: flight, changeset: changeset, page_title: "Edit flight", airports: airports)
  end

  def update(conn, %{"id" => id, "flight" => flight_params}) do
    flight = FlightContext.get_flight!(id) |> FlightContext.preload_flight_airports()

    case FlightContext.update_flight(flight, flight_params) do
      {:ok, flight} ->
        conn
        |> put_flash(:info, "Flight updated successfully.")
        |> redirect(to: Routes.flight_path(conn, :show, flight))

      {:error, %Ecto.Changeset{} = changeset} ->
        airports = AirportContext.list_airports()
        render(conn, "edit.html", flight: flight, changeset: changeset, page_title: "Error updating flight", airports: airports)
    end
  end

  def delete(conn, %{"id" => id}) do
    flight = FlightContext.get_flight!(id)
    {:ok, _flight} = FlightContext.delete_flight(flight)

    conn
    |> put_flash(:info, "Flight deleted successfully.")
    |> redirect(to: Routes.flight_path(conn, :index))
  end

  def upcoming(conn, params) do
    flights = FlightContext.list_upcoming(params)
    |> FlightContext.preload_flights_airports()
    |> Enum.filter(fn (flight) -> Date.compare(flight.departure_date, Date.utc_today()) == :gt end)
    |> Enum.sort(fn (flight1, flight2) -> Time.compare(flight1.departure_time, flight2.departure_time) == :gt end)
    |> Enum.sort(fn (flight1, flight2) -> Date.compare(flight1.departure_date, flight2.departure_date) == :lt end)

    render(conn, "upcoming_flights.html", flights: flights, page_title: "All upcoming flights")
  end

  def show_upcoming(conn, %{"id" => id}) do
    flight = FlightContext.get_flight(id)
    # Check if flight exists
    if flight == nil do
      conn
      |> put_flash(:error, "Flight with id #{id} does not exist.")
      |> redirect(to: Routes.flight_path(conn, :upcoming))
    end
    flight = FlightContext.preload_flight_airports(flight)
    d_city = AirportContext.get_city!(flight.departure_airport.city_id) |> AirportContext.preload_city_country()
    a_city = AirportContext.get_city!(flight.arrival_airport.city_id) |> AirportContext.preload_city_country()

    render(conn, "show_upcoming.html", flight: flight, page_title: "Flight #{flight.id}",
      departure_city: d_city, arrival_city: a_city)
  end

  def purchase_ticket(conn,  %{"id" => id}) do
    flight = FlightContext.get_flight(id)
    # Check if flight exists
    if flight == nil do
      conn
      |> put_flash(:error, "Flight with id #{id} does not exist.")
      |> redirect(to: Routes.flight_path(conn, :upcoming))
    end
    flight = FlightContext.preload_flight_airports(flight)
    d_city = AirportContext.get_city!(flight.departure_airport.city_id) |> AirportContext.preload_city_country()
    a_city = AirportContext.get_city!(flight.arrival_airport.city_id) |> AirportContext.preload_city_country()

    changeset = TicketContext.change_ticket(%Ticket{})
    render(conn, "purchase-ticket.html", page_title: "Purchase ticket", changeset: changeset, flight: flight,
      departure_city: d_city, arrival_city: a_city)
  end

  def confirm_purchase(conn, params) do
    # Check if flight exists
    flight_id = params["ticket"]["flight_id"]
    flight = FlightContext.get_flight(flight_id)
    if flight == nil do
      conn
      |> put_flash(:error, "Flight with id #{flight_id} does not exist.")
      |> redirect(to: Routes.flight_path(conn, :upcoming))
    end

    # Check if flight is upcoming
    if Date.compare(flight.departure_date, Date.utc_today()) == :lt do
      conn
      |> put_flash(:error, "You cannot purchase a ticket for flight #{flight_id} anymore.")
      |> redirect(to: Routes.flight_path(conn, :upcoming))
    end

    # Check if user exists
    user_id = params["ticket"]["user_id"]
    user = UserContext.get_user(user_id)
    if user == nil do
      conn
      |> put_flash(:error, "User with id #{user_id} does not exist.")
      |> redirect(to: Routes.flight_path(conn, :upcoming))
    end

    case TicketContext.create_ticket(%{flight_id: flight_id, user_id: user_id}) do
      {:ok, _ticket} ->
        conn
        |> put_flash(:info, "Ticket purchased successfully.")
        |> redirect(to: Routes.page_path(conn, :user_index))

      {:error, %Ecto.Changeset{} = changeset} ->
        flight = FlightContext.get_flight(flight_id)
        # Check if flight exists
        if flight == nil do
          conn
          |> put_flash(:error, "Flight with id #{flight_id} does not exist.")
          |> redirect(to: Routes.flight_path(conn, :upcoming))
        end
        flight = FlightContext.preload_flight_airports(flight)
        d_city = AirportContext.get_city!(flight.departure_airport.city_id) |> AirportContext.preload_city_country()
        a_city = AirportContext.get_city!(flight.arrival_airport.city_id) |> AirportContext.preload_city_country()


        render(conn, "purchase-ticket.html", page_title: "Error purchasing ticket", changeset: changeset, flight: flight,
          departure_city: d_city, arrival_city: a_city)
    end
  end
end
