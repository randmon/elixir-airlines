defmodule AirlinesIpmajorWeb.UserController do
  use AirlinesIpmajorWeb, :controller

  alias AirlinesIpmajor.UserContext
  alias AirlinesIpmajor.UserContext.User
  alias AirlinesIpmajor.AirportContext

  def index(conn, _params) do
    users = UserContext.list_users()
    |> UserContext.preload_users_countries()

    render(conn, "index.html", users: users, page_title: "User overview")
  end

  # Used by admins to create new users
  def new(conn, _params) do
    changeset = UserContext.change_user(%User{})
    roles = UserContext.get_acceptable_roles()
    countries = AirportContext.list_countries()
    render(conn, "new.html", changeset: changeset, acceptable_roles: roles, countries: countries, page_title: "Create user")
  end

  def create(conn, %{"user" => user_params}) do
    case UserContext.create_user(user_params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, gettext("User created successfully."))
        |> redirect(to: Routes.user_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        roles = UserContext.get_acceptable_roles()
        countries = AirportContext.list_countries()
        render(conn, "new.html", changeset: changeset, acceptable_roles: roles, countries: countries, page_title: "Error creating user")
    end
  end

  # Used by users to register
  def register(conn, _params) do
    changeset = UserContext.change_user_registration(%User{})
    countries = AirportContext.list_countries()
    render(conn, "register.html", changeset: changeset, countries: countries, page_title: "Register")
  end

  def register_create(conn, %{"user" => user_params}) do
    case UserContext.create_user(user_params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, gettext("User created successfully."))
        |> redirect(to: Routes.session_path(conn, :new))

      {:error, %Ecto.Changeset{} = changeset} ->
        countries = AirportContext.list_countries()
        render(conn, "register.html", changeset: changeset, countries: countries, page_title: "Error creating user")
    end
  end

  def show(conn, %{"id" => id}) do
    # If user is not admin, and is trying to see another user's info, redirect to index
    current_user = conn.assigns.current_user
    if current_user.role != "Admin" && to_string(current_user.id) != id do
      conn
        |> put_flash(:error, "Unauthorized")
        |> redirect(to: Routes.page_path(conn, :index))
    end
    user = UserContext.get_user(id)
    |> UserContext.preload_users_countries()
    # Check if user exists
    if user == nil do
      conn
        |> put_flash(:error, "User with id #{id} does not exist.")
        |> redirect(to: Routes.user_path(conn, :index))
    end
    render(conn, "show.html", user: user, page_title: gettext("Show user info"))
  end

  # Used by admins to edit users
  def edit(conn, %{"id" => id}) do
    user = UserContext.get_user(id)
    # Check if user exists
    if user == nil do
      conn
        |> put_flash(:error, "User with id #{id} does not exist.")
        |> redirect(to: Routes.user_path(conn, :index))
    end
    changeset = UserContext.change_user(user)

    roles = UserContext.get_acceptable_roles()
    countries = AirportContext.list_countries()
    render(conn, "edit.html", user: user, changeset: changeset, acceptable_roles: roles, countries: countries, page_title: "Edit user info")
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = UserContext.get_user!(id)

    case UserContext.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, gettext("User updated successfully."))
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        roles = UserContext.get_acceptable_roles()
        countries = AirportContext.list_countries()
        render(conn, "edit.html", user: user, changeset: changeset, acceptable_roles: roles, countries: countries, page_title: "Error updating user")
    end
  end

  def edit_registration(conn, _params) do
    user = conn.assigns.current_user
    changeset = UserContext.change_user_registration(user)
    countries = AirportContext.list_countries()
    render(conn, "edit-registration.html", user: user, countries: countries, changeset: changeset, page_title: "Edit your info")
  end

  def update_registration(conn, %{"user" => user_params}) do
    user = conn.assigns.current_user
    case UserContext.update_user_registration(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, gettext("User updated successfully."))
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        countries = AirportContext.list_countries()
        render(conn, "edit-registration.html", user: user, countries: countries, changeset: changeset, page_title: "Error updating user")
    end
  end

  def delete(conn, %{"id" => id}) do
    # If user is not admin, and is trying to delete another user, redirect to index
    current_user = conn.assigns.current_user
    if current_user.role != "Admin" && to_string(current_user.id) != id do
      conn
        |> put_flash(:error, gettext("Unauthorized"))
        |> redirect(to: Routes.page_path(conn, :index))
    else
      if id == "1" do
      conn
        |> put_flash(:error, gettext("You cannot delete user with id 1."))
        |> redirect(to: Routes.user_path(conn, :index))
      else
        user = UserContext.get_user!(id)
        {:ok, _user} = UserContext.delete_user(user)

        # If the logged in user is the same as deleted, logout
        if to_string(current_user.id) == id do
          conn
          |> put_flash(:info, gettext("Your account has been deleted."))
          |> redirect(to: Routes.session_path(conn, :logout))
        else
        # Otherwise we know it's an admin, can redirect to user list
          conn
          |> put_flash(:info, gettext("User with id %{id} has been deleted.", id: id))
          |> redirect(to: Routes.user_path(conn, :index))
        end
      end
    end
  end

  def generate_api_key(conn, _params) do
    current_user = conn.assigns.current_user
    if current_user != nil do
      key = generate_random_string()
      case UserContext.generate_api_key(current_user, key) do
        {:ok, _} ->
          conn
          |> put_flash(:info, gettext("API key generated successfully."))
          |> redirect(to: Routes.page_path(conn, :user_index))

        {:error, _} ->
          conn
          |> put_flash(:error, gettext("Error generating API key."))
          |> redirect(to: Routes.page_path(conn, :user_index))
      end
    else
      conn
        |> put_flash(:error, gettext("Please login to generate an API key."))
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  defp generate_random_string() do
    for _ <- 1..50, into: "", do: <<Enum.random('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')>>
  end
end
