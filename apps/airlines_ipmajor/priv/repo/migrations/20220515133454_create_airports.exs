defmodule AirlinesIpmajor.Repo.Migrations.CreateAirports do
  use Ecto.Migration

  def change do
    create table(:airports) do
      add :code, :string, null: false
      add :name, :string, null: false
      add :city_id, references(:cities), null: false
    end

    create unique_index(:airports, [:code], name: "airports_unique_index")
  end
end
