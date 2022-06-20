defmodule AirlinesIpmajor.EmployeeContext.Employee do
  use Ecto.Schema
  import Ecto.Changeset
  alias AirlinesIpmajor.FlightContext.Flight

  schema "employees" do
    field :birthdate, :date
    field :first_name, :string
    field :last_name, :string
    many_to_many :flights, Flight, join_through: "crew_members"

    timestamps()
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:first_name, :last_name, :birthdate])
    |> validate_required([:first_name, :last_name, :birthdate])
  end
end
