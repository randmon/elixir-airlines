defmodule AirlinesIpmajorWeb.AirlinesRestController do
  use AirlinesIpmajorWeb, :controller

  alias AirlinesIpmajor.FlightContext
  alias AirlinesIpmajor.AirportContext
  alias AirlinesIpmajor.TicketContext
  alias AirlinesIpmajor.UserContext

  def flights(conn, _params) do
    flights = FlightContext.list_flights()
    |> FlightContext.preload_flights_airports()

    render(conn, "flights.json", flights: flights)
  end

  def flight(conn, %{"id" => id}) do
    flight = FlightContext.get_flight(id)
    # Check if flight exists
    if flight == nil do
      conn
      |> send_resp(404, "Flight with id #{id} does not exist.")
    end
    flight = FlightContext.preload_flight_airports(flight)

    d_city = AirportContext.get_city!(flight.departure_airport.city_id) |> AirportContext.preload_city_country()
    a_city = AirportContext.get_city!(flight.arrival_airport.city_id) |> AirportContext.preload_city_country()
    render(conn, "flight.json", flight: flight, departure_city: d_city, arrival_city: a_city)
  end

  def airports(conn, _params) do
    airports = AirportContext.list_airports()
    |> AirportContext.preload_airport_city()

    render(conn, "airports.json", airports: airports)
  end

  def airport(conn, %{"id" => id}) do
    airport = AirportContext.get_airport(id)
    # Check if airport exists
    if airport == nil do
      conn
      |> send_resp(404, "Airport with id #{id} does not exist.")
    end
    airport = AirportContext.preload_airport_city(airport)
    render(conn, "airport.json", airport: airport)
  end

  def cities(conn, _params) do
    cities = AirportContext.list_cities()
    |> AirportContext.preload_city_country()

    render(conn, "cities.json", cities: cities)
  end

  def city(conn, %{"id" => id}) do
    city = AirportContext.get_city(id)
    # Check if city exists
    if city == nil do
      conn
      |> send_resp(404, "City with id #{id} does not exist.")
    end
    city = AirportContext.preload_city_country(city)
    render(conn, "city.json", city: city)
  end

  def countries(conn, _params) do
    countries = AirportContext.list_countries()
    render(conn, "countries.json", countries: countries)
  end

  def country(conn, %{"id" => id}) do
    country = AirportContext.get_country(id)
    # Check if country exists
    if country == nil do
      conn
      |> send_resp(404, "Country with id #{id} does not exist.")
    end
    render(conn, "country.json", country: country)
  end

  # private

  def user_tickets(conn,_params) do
    user = conn.assigns.signed_user
    tickets = TicketContext.get_user_tickets(user)
    |> TicketContext.preload_tickets_flights()
    render(conn, "tickets.json", tickets: tickets)
  end

  def secret(conn, _params) do
    render(conn, "secret.json", secret: "Did you hear about the restaurant on the moon? Great food, no atmosphere.")
  end

  def users(conn, _params) do
    users = UserContext.list_users()
    |> UserContext.preload_users_countries()
    render(conn, "users.json", users: users)
  end
end
