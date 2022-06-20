defmodule AirlinesIpmajor.Repo.Migrations.CreateCountries do
  use Ecto.Migration

  def change do
    create table(:countries) do
      add :code, :string, null: false
      add :name, :string, null: false
    end

    create unique_index(:countries, [:code], name: "countries_unique_index")
  end
end
