defmodule AirlinesIpmajor.TicketContext.Ticket do
  use Ecto.Schema
  import Ecto.Changeset
  alias AirlinesIpmajor.FlightContext.Flight
  alias AirlinesIpmajor.UserContext.User

  schema "tickets" do
    belongs_to :user, User
    belongs_to :flight, Flight
  end

  @doc false
  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [:user_id, :flight_id])
    |> validate_required([:user_id, :flight_id])
    |> unique_constraint([:user_id, :flight_id], name: "tickets_user_id_flight_id_index", message: "You have already purchased this ticket.")
  end
end
