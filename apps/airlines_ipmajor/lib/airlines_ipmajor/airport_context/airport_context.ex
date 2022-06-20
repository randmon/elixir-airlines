defmodule AirlinesIpmajor.AirportContext do
  import Ecto.Query, warn: false
  alias AirlinesIpmajor.Repo
  alias AirlinesIpmajor.AirportContext.Country
  alias AirlinesIpmajor.AirportContext.City
  alias AirlinesIpmajor.AirportContext.Airport

  # Country

  def list_countries do
    Repo.all(Country)
  end

  def get_country!(id), do: Repo.get!(Country, id)
  def get_country(id), do: Repo.get(Country, id)

  def create_country(attrs \\ %{}) do
    %Country{}
    |> Country.changeset(attrs)
    |> Repo.insert()
  end

  # City

  def list_cities do
    Repo.all(City)
  end

  def get_city!(id), do: Repo.get!(City, id)
  def get_city(id), do: Repo.get(City, id)

  def create_city(attrs \\ %{}) do
    %City{}
    |> City.changeset(attrs)
    |> Repo.insert()
  end

  # Airport

  def list_airports do
    Repo.all(Airport)
  end

  def get_airport!(id), do: Repo.get!(Airport, id)
  def get_airport(id), do: Repo.get(Airport, id)

  def create_airport(attrs \\ %{}) do
    %Airport{}
    |> Airport.changeset(attrs)
    |> Repo.insert()
  end

  def preload_airport_city(airport) do
    Repo.preload(airport, :city)
  end

  def preload_city_country(city) do
    Repo.preload(city, :country)
  end
end
