defmodule AirlinesIpmajor.FlightContext.Flight do
  use Ecto.Schema
  import Ecto.Changeset
  alias AirlinesIpmajor.AirportContext.Airport
  alias AirlinesIpmajor.UserContext.User

  schema "flights" do
    field :departure_date, :date
    field :departure_time, :time
    field :price, :decimal
    belongs_to :departure_airport, Airport
    belongs_to :arrival_airport, Airport
    many_to_many :tickets, User, join_through: "tickets"
  end

  @doc false
  def changeset(flight, attrs) do
    flight
    |> cast(attrs, [:departure_date, :departure_time, :price, :departure_airport_id, :arrival_airport_id])
    |> validate_required([:departure_date, :departure_time, :price, :departure_airport_id, :arrival_airport_id])
    |> validate_number(:price, greater_than: 0)
    |> validate_airports_different("airports must be different.")
  end

  def validate_airports_different(changeset, message) do
    id1 = get_field(changeset, :departure_airport_id)
    id2 = get_field(changeset, :arrival_airport_id)

    case id1 == id2 do
      true -> add_error(changeset, :departure_airport_id, message)
      false -> changeset
    end
  end
end
