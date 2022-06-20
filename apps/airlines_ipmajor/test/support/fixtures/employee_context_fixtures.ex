defmodule AirlinesIpmajor.EmployeeContextFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AirlinesIpmajor.EmployeeContext` context.
  """

  @doc """
  Generate a employee.
  """
  def employee_fixture(attrs \\ %{}) do
    {:ok, employee} =
      attrs
      |> Enum.into(%{
        birthdate: ~D[2022-06-19],
        first_name: "some first_name",
        last_name: "some last_name"
      })
      |> AirlinesIpmajor.EmployeeContext.create_employee()

    employee
  end
end
