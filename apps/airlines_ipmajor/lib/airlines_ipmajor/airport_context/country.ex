defmodule AirlinesIpmajor.AirportContext.Country do
  use Ecto.Schema
  import Ecto.Changeset
  alias AirlinesIpmajor.AirportContext.City
  alias AirlinesIpmajor.UserContext.User

  schema "countries" do
    field :code, :string
    field :name, :string
    has_many :cities, City
    has_many :users, User
  end

  @doc false
  def changeset(country, attrs) do
    country
    |> cast(attrs, [:code, :name])
    |> validate_required([:code, :name])
  end
end
