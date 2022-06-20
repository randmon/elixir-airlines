defmodule AirlinesIpmajor.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees) do
      add :first_name, :string
      add :last_name, :string
      add :birthdate, :date

      timestamps()
    end
  end
end
