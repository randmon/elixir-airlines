defmodule AirlinesIpmajor.Repo.Migrations.CreateCities do
  use Ecto.Migration

  def change do
    create table(:cities) do
      add :name, :string, null: false
      add :country_id, references(:countries), null: false
    end

    create unique_index(:cities, [:name], name: "cities_unique_index")
  end
end
