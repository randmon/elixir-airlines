defmodule AirlinesIpmajor.FlightContext do
  import Ecto.Query, warn: false
  alias AirlinesIpmajor.Repo

  alias AirlinesIpmajor.FlightContext.Flight
  alias AirlinesIpmajor.TicketContext

  def list_flights, do: Repo.all(Flight)

  def get_flight!(id), do: Repo.get!(Flight, id)
  def get_flight(id), do: Repo.get(Flight, id)

  def create_flight(attrs \\ %{}) do
    %Flight{}
    |> Flight.changeset(attrs)
    |> Repo.insert()
  end

  def update_flight(%Flight{} = flight, attrs) do
    flight
    |> Flight.changeset(attrs)
    |> Repo.update()
  end

  def delete_flight(%Flight{} = flight) do
    # Delete all associated tickets
    TicketContext.get_flight_tickets(flight)
    |> Enum.each(fn (ticket) -> TicketContext.delete_ticket(ticket) end)

    # Delete the flight
    Repo.delete(flight)
  end

  def change_flight(%Flight{} = flight, attrs \\ %{}) do
    Flight.changeset(flight, attrs)
  end

  def preload_flight_airports(%Flight{} = flight) do
    Repo.preload(flight, [:departure_airport, :arrival_airport])
  end

  def preload_flights_airports(flights) do
    flights
    |> Repo.preload([:departure_airport, :arrival_airport])
    |> Repo.preload([departure_airport: [:city], arrival_airport: [:city]])
  end
end
