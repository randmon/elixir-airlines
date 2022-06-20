defmodule AirlinesIpmajor.UserContext do
  import Ecto.Query, warn: false
  alias AirlinesIpmajor.Repo
  alias AirlinesIpmajor.UserContext.User
  alias AirlinesIpmajor.TicketContext

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def get_user(id), do: Repo.get(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def register_user(attrs \\ %{}) do
    %User{}
    |> User.changeset_registration(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def update_user_registration(%User{} = user, attrs) do
    user
    |> User.changeset_registration(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    # Delete all associated tickets
    TicketContext.get_user_tickets(user)
    |> Enum.each(fn (ticket) -> TicketContext.delete_ticket(ticket) end)

    # Delete user
    Repo.delete(user)
  end

  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def change_user_registration(%User{} = user, attrs \\ %{}) do
    User.changeset_registration(user, attrs)
  end

  defdelegate get_acceptable_roles(), to: User

  def authenticate_user(username, password) do
    case Repo.get_by(User, username: username) do
      nil ->
        Pbkdf2.no_user_verify()
        {:error, :invalid_credentials}

      user ->
        if Pbkdf2.verify_pass(password, user.hashed_password) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end

  def generate_api_key(%User{} = user, key) do
    user
    |> User.changeset_api(%{api_key: key})
    |> Repo.update()
  end

  def search_by_api_key(key) do
    Repo.get_by(User, api_key: key)
  end

  def preload_users_countries(users) do
    Repo.preload(users, [:country])
  end
end
