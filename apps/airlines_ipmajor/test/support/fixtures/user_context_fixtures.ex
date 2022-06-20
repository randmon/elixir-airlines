defmodule AirlinesIpmajor.UserContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AirlinesIpmajor.UserContext` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        birthdate: ~D[2022-05-08],
        first_name: "some first_name",
        hashed_password: "some hashed_password",
        last_name: "some last_name",
        username: "some username"
      })
      |> AirlinesIpmajor.UserContext.create_user()

    user
  end
end
