defmodule AirlinesIpmajor.CrewMemberContext.CrewMember do
  use Ecto.Schema
  import Ecto.Changeset
  alias AirlinesIpmajor.FlightContext.Flight
  alias AirlinesIpmajor.EmployeeContext.Employee

  schema "crew_members" do
    belongs_to :employee, Employee
    belongs_to :flight, Flight
  end

  @doc false
  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [:employee_id, :flight_id])
    |> validate_required([:employee_id, :flight_id])
    |> unique_constraint([:employee_id, :flight_id], name: "crew_member_id_flight_id_index", message: "Employee has already been assigned to this flight.")
  end
end
