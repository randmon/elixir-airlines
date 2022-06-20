defmodule AirlinesIpmajorWeb.AirlinesRestView do
  use AirlinesIpmajorWeb, :view
  alias AirlinesIpmajorWeb.AirlinesRestView

  def render("flights.json", %{flights: flights}), do: render_many(flights, AirlinesRestView, "flight.json")

  def render("flight.json", %{flight: flight}), do: render_one(flight, AirlinesRestView, "flight.json")

  def render("flight.json", %{airlines_rest: flight}) do
    %{
      id: flight.id,
      departure_airport: render_one(flight.departure_airport, AirlinesRestView, "flight-airport.json"),
      arrival_airport: render_one(flight.arrival_airport, AirlinesRestView, "flight-airport.json"),
      departure_date: flight.departure_date,
      departure_time: flight.departure_time,
      price: flight.price
    }
  end

  def render("flight-airport.json", %{airlines_rest: airport}) do
    %{
      id: airport.id,
      name: airport.name,
      code: airport.code,
      city: airport.city_id
    }
  end

  def render("airports.json", %{airports: airports}), do: render_many(airports, AirlinesRestView, "airport.json")

  def render("airport.json", %{airport: airport}), do: render_one(airport, AirlinesRestView, "airport.json")

  def render("airport.json", %{airlines_rest: airport}) do
    %{
      id: airport.id,
      name: airport.name,
      code: airport.code,
      city: render_one(airport.city, AirlinesRestView, "airport-city.json")
    }
  end

  def render("airport-city.json", %{airlines_rest: city}) do
    %{
      id: city.id,
      name: city.name,
      country: city.country_id
    }
  end

  def render("cities.json", %{cities: cities}), do: render_many(cities, AirlinesRestView, "city.json")

  def render("city.json", %{city: city}), do: render_one(city, AirlinesRestView, "city.json")

  def render("city.json", %{airlines_rest: city}) do
    %{
      id: city.id,
      name: city.name,
      country: render_one(city.country, AirlinesRestView, "country.json")
    }
  end

  def render("country.json", %{country: country}), do: render_one(country, AirlinesRestView, "country.json")

  def render("countries.json", %{countries: countries}), do: render_many(countries, AirlinesRestView, "country.json")

  def render("country.json", %{airlines_rest: country}) do
    %{
      id: country.id,
      name: country.name,
      code: country.code
    }
  end

  # private

  def render("tickets.json", %{tickets: tickets}), do: render_many(tickets, AirlinesRestView, "ticket.json")


  def render("ticket.json", %{airlines_rest: ticket}) do
    %{
      id: ticket.id,
      flight: render_one(ticket.flight, AirlinesRestView, "flight.json"),
    }
  end

  def render("secret.json", %{secret: secret}) do
    %{
      secret: secret
    }
  end

  def render("users.json", %{users: users}), do: render_many(users, AirlinesRestView, "user.json")

  def render("user.json", %{airlines_rest: user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      role: user.role,
      first_name: user.first_name,
      last_name: user.last_name,
      country: user.country.name
    }
  end
end
