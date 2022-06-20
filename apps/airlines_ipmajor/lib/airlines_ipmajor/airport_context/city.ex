defmodule AirlinesIpmajor.AirportContext.City do
  use Ecto.Schema
  import Ecto.Changeset
  alias AirlinesIpmajor.AirportContext.Country
  alias AirlinesIpmajor.AirportContext.Airport

  schema "cities" do
    field :name, :string
    belongs_to :country, Country
    has_many :airports, Airport
  end

  @doc false
  def changeset(city, attrs) do
    city
    |> cast(attrs, [:name, :country_id])
    |> validate_required([:name, :country_id])
  end
end
