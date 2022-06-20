defmodule AirlinesIpmajor.UserContext.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias AirlinesIpmajor.AirportContext.Country
  alias AirlinesIpmajor.FlightContext.Flight

  @acceptable_roles ["Admin", "User"]

  schema "users" do
    field :username, :string
    field :email, :string
    field :password, :string, virtual: true
    field :hashed_password, :string
    field :role, :string, default: "User"
    field :first_name, :string
    field :last_name, :string
    field :birthdate, :date
    many_to_many :tickets, Flight, join_through: "tickets"
    field :api_key, :string
    belongs_to :country, Country
  end

  def get_acceptable_roles, do: @acceptable_roles

  def changeset_registration(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :first_name, :last_name, :birthdate, :country_id])
    |> validate_required([:username, :email, :password, :first_name, :last_name, :birthdate, :country_id])
    |> unique_constraint(:username, name: "users_unique_username")
    |> unique_constraint(:email, name: "users_unique_email")
    |> foreign_key_constraint(:country_id, name: "users_country_id_fkey")
    |> validate_length(:password, min: 8)
    |> put_password_hash()
  end

  def changeset(user, attrs) do
    # A changeset that includes the role field, it is only allowed if the user is an admin
    user
    |> cast(attrs, [:username, :email, :password, :first_name, :last_name, :birthdate, :role, :country_id])
    |> validate_required([:username, :email, :password, :first_name, :last_name, :birthdate, :role, :country_id])
    |> unique_constraint(:username, name: "users_unique_username")
    |> unique_constraint(:email, name: "users_unique_email")
    |> foreign_key_constraint(:country_id, name: "users_country_id_fkey")
    |> validate_length(:password, min: 8)
    |> validate_inclusion(:role, @acceptable_roles, message: "Role must be one of: #{Enum.join(@acceptable_roles, ", ")}")
    |> put_password_hash()
  end

  def changeset_api(user, attrs) do
    user
    |> cast(attrs, [:api_key])
    |> validate_required([:api_key], message: "Can't be blank")
    |> validate_length(:api_key, min: 8)
  end

  defp put_password_hash(
      %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
    ) do
    change(changeset, hashed_password: Pbkdf2.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset
end
