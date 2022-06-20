defmodule AirlinesIpmajor.TicketContext do
  import Ecto.Query, warn: false
  alias AirlinesIpmajor.Repo

  alias AirlinesIpmajor.UserContext.User
  alias AirlinesIpmajor.TicketContext.Ticket
  alias AirlinesIpmajor.FlightContext.Flight

  def list_tickets, do: Repo.all(Ticket)

  def get_ticket!(id), do: Repo.get!(Ticket, id)

  def create_ticket(attrs \\ %{}) do
    %Ticket{}
    |> Ticket.changeset(attrs)
    |> Repo.insert()
  end

  def update_ticket(%Ticket{} = ticket, attrs) do
    ticket
    |> Ticket.changeset(attrs)
    |> Repo.update()
  end

  def delete_ticket(%Ticket{} = ticket) do
    Repo.delete(ticket)
  end

  def change_ticket(%Ticket{} = ticket, attrs \\ %{}) do
    Ticket.changeset(ticket, attrs)
  end

  def get_user_tickets(%User{} = user) do
    # Get all tickets that are owned by the user
    Repo.all(Ticket)
    |> Enum.filter(fn (ticket) -> ticket.user_id == user.id end)
  end

  def get_flight_tickets(%Flight{} = flight) do
    Repo.all(Ticket)
    |> Enum.filter(fn (ticket) -> ticket.flight_id == flight.id end)
  end

  def preload_ticket_flight(%Ticket{} = ticket) do
    Repo.preload(ticket, [:flight])
  end

  def preload_ticket_user(%Ticket{} = ticket) do
    Repo.preload(ticket, [:user])
  end

  def preload_tickets_flights(tickets) do
    tickets
    |> Repo.preload([:flight])
    |> Repo.preload([flight: [:departure_airport, :arrival_airport]])
    |> Repo.preload([flight: [departure_airport: [:city], arrival_airport: [:city]]])
  end
end
