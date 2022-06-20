defmodule AirlinesIpmajor.CrewMemberContext do
  import Ecto.Query, warn: false
  alias AirlinesIpmajor.Repo

  alias AirlinesIpmajor.EmployeeContext.Employee
  alias AirlinesIpmajor.CrewMemberContext.CrewMember
  alias AirlinesIpmajor.FlightContext.Flight

  def list_crew_members, do: Repo.all(CrewMember)

  def get_crew_member!(id), do: Repo.get!(CrewMember, id)

  def create_crew_member(attrs \\ %{}) do
    %CrewMember{}
    |> CrewMember.changeset(attrs)
    |> Repo.insert()
  end

  def update_crew_member(%CrewMember{} = crew_member, attrs) do
    crew_member
    |> CrewMember.changeset(attrs)
    |> Repo.update()
  end

  def delete_crew_member(%CrewMember{} = crew_member) do
    Repo.delete(crew_member)
  end

  def change_crew_member(%CrewMember{} = crew_member, attrs \\ %{}) do
    CrewMember.changeset(crew_member, attrs)
  end

  def get_employee_flights(%Employee{} = employee) do
    # Get all flights that are assigned to the employee
    Repo.all(CrewMember)
    |> Enum.filter(fn (crew_member) -> crew_member.employee_id == employee.id end)
  end

  def get_flight_crew_members(%Flight{} = flight) do
    # Get all crew members that are assigned to the flight
    Repo.all(CrewMember)
    |> Enum.filter(fn (crew_member) -> crew_member.flight_id == flight.id end)
  end
end
