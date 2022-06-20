defmodule AirlinesIpmajor.Repo.Migrations.CreateCrewMembers do
  use Ecto.Migration

  def change do
    create table(:crew_members) do
      add :employee_id, references(:employees)
      add :flight_id, references(:flights)
    end

    create unique_index(:crew_members, [:employee_id, :flight_id])
  end
end
