defmodule AirlinesIpmajor.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :email, :string, null: false
      add :hashed_password, :string, null: false
      add :role, :string, null: false
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :birthdate, :date, null: false
      add :api_key, :string
      add :country_id, references(:countries), null: false
    end

    create unique_index(:users, [:username], name: "users_unique_username")
    create unique_index(:users, [:email], name: "users_unique_email")
    create unique_index(:users, [:api_key], name: "users_unique_api_key")
  end
end
