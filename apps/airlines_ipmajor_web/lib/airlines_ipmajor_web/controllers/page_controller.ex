defmodule AirlinesIpmajorWeb.PageController do
  use AirlinesIpmajorWeb, :controller
  alias AirlinesIpmajor.FlightContext
  alias AirlinesIpmajor.TicketContext
  alias AirlinesIpmajor.AirportContext

  def index(conn, params) do
    flights = FlightContext.list_upcoming(params)
    |> FlightContext.preload_flights_airports()
    |> Enum.filter(fn (flight) -> Date.compare(flight.departure_date, Date.utc_today()) == :gt end)
    |> Enum.sort(fn (flight1, flight2) -> Time.compare(flight1.departure_time, flight2.departure_time) == :gt end)
    |> Enum.sort(fn (flight1, flight2) -> Date.compare(flight1.departure_date, flight2.departure_date) == :lt end)
    |> Enum.slice(0, 5)

    airports = AirportContext.list_airports()

    render(conn, "index.html", page_title: "Home", flights: flights, airports: airports)
  end

  def user_index(conn, _params) do
    # get user in session
    current_user = conn.assigns.current_user
    # get all tickets for user
    alltickets = TicketContext.get_user_tickets(current_user)
    |> TicketContext.preload_tickets_flights()
    |> Enum.sort(fn (flight1, flight2) -> Time.compare(flight1.flight.departure_time, flight2.flight.departure_time) == :gt end)
    |> Enum.sort(fn (flight1, flight2) -> Date.compare(flight1.flight.departure_date, flight2.flight.departure_date) == :lt end)

    tickets = alltickets
    |> Enum.filter(fn (ticket) -> Date.compare(ticket.flight.departure_date, Date.utc_today()) == :gt end)

    past_tickets = alltickets
    |> Enum.filter(fn (ticket) -> Date.compare(ticket.flight.departure_date, Date.utc_today()) != :gt end)

    # render
    render(conn, "user_area.html", page_title: "User area", tickets: tickets, past_tickets: past_tickets)
  end

  def admin_index(conn, _params) do
    render(conn, "admin_area.html", page_title: "Admin area")
  end
end
