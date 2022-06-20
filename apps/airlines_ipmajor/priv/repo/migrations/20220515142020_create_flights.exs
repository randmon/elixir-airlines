defmodule AirlinesIpmajor.Repo.Migrations.CreateFlights do
  use Ecto.Migration

  def change do
    create table(:flights) do
      add :departure_date, :date, null: false
      add :departure_time, :time, null: false
      add :price, :decimal, precision: 10, scale: 2, null: false
      add :departure_airport_id, references(:airports), null: false
      add :arrival_airport_id, references(:airports), null: false
    end
  end
end
