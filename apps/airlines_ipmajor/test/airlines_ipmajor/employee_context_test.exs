defmodule AirlinesIpmajor.EmployeeContextTest do
  use AirlinesIpmajor.DataCase

  alias AirlinesIpmajor.EmployeeContext

  describe "employees" do
    alias AirlinesIpmajor.EmployeeContext.Employee

    import AirlinesIpmajor.EmployeeContextFixtures

    @invalid_attrs %{birthdate: nil, first_name: nil, last_name: nil}

    test "list_employees/0 returns all employees" do
      employee = employee_fixture()
      assert EmployeeContext.list_employees() == [employee]
    end

    test "get_employee!/1 returns the employee with given id" do
      employee = employee_fixture()
      assert EmployeeContext.get_employee!(employee.id) == employee
    end

    test "create_employee/1 with valid data creates a employee" do
      valid_attrs = %{birthdate: ~D[2022-06-19], first_name: "some first_name", last_name: "some last_name"}

      assert {:ok, %Employee{} = employee} = EmployeeContext.create_employee(valid_attrs)
      assert employee.birthdate == ~D[2022-06-19]
      assert employee.first_name == "some first_name"
      assert employee.last_name == "some last_name"
    end

    test "create_employee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = EmployeeContext.create_employee(@invalid_attrs)
    end

    test "update_employee/2 with valid data updates the employee" do
      employee = employee_fixture()
      update_attrs = %{birthdate: ~D[2022-06-20], first_name: "some updated first_name", last_name: "some updated last_name"}

      assert {:ok, %Employee{} = employee} = EmployeeContext.update_employee(employee, update_attrs)
      assert employee.birthdate == ~D[2022-06-20]
      assert employee.first_name == "some updated first_name"
      assert employee.last_name == "some updated last_name"
    end

    test "update_employee/2 with invalid data returns error changeset" do
      employee = employee_fixture()
      assert {:error, %Ecto.Changeset{}} = EmployeeContext.update_employee(employee, @invalid_attrs)
      assert employee == EmployeeContext.get_employee!(employee.id)
    end

    test "delete_employee/1 deletes the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{}} = EmployeeContext.delete_employee(employee)
      assert_raise Ecto.NoResultsError, fn -> EmployeeContext.get_employee!(employee.id) end
    end

    test "change_employee/1 returns a employee changeset" do
      employee = employee_fixture()
      assert %Ecto.Changeset{} = EmployeeContext.change_employee(employee)
    end
  end
end
