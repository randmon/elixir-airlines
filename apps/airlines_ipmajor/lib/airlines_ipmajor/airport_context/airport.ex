defmodule AirlinesIpmajor.AirportContext.Airport do
  use Ecto.Schema
  import Ecto.Changeset
  alias AirlinesIpmajor.AirportContext.City

  schema "airports" do
    field :code, :string
    field :name, :string
    belongs_to :city, City
  end

  @doc false
  def changeset(airport, attrs) do
    airport
    |> cast(attrs, [:code, :name, :city_id])
    |> validate_required([:code, :name, :city_id])
  end
end
