defmodule AssociationDemo.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :user_id, references(:users)
      add :flight_id, references(:flights)
    end

    create unique_index(:tickets, [:user_id, :flight_id])
  end
end
