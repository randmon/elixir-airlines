# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     AirlinesIpmajor.Repo.insert!(%AirlinesIpmajor.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


{:ok,_cs} =
  AirlinesIpmajor.AirportContext.create_country(%{
    "code" => "PT",
    "name" => "Portugal"
    })

{:ok,_cs} =
  AirlinesIpmajor.AirportContext.create_country(%{
    "code" => "ES",
    "name" => "Spain"
    })

{:ok,_cs} =
  AirlinesIpmajor.AirportContext.create_country(%{
    "code" => "BE",
    "name" => "Belgium"
    })

{:ok,_cs} =
  AirlinesIpmajor.AirportContext.create_country(%{
    "code" => "FR",
    "name" => "France"
    })

{:ok,_cs} =
  AirlinesIpmajor.AirportContext.create_country(%{
    "code" => "UK",
    "name" => "United Kingdom"
    })

{:ok,_cs} =
  AirlinesIpmajor.AirportContext.create_country(%{
    "code" => "DE",
    "name" => "Germany"
    })

{:ok,_cs} =
  AirlinesIpmajor.AirportContext.create_country(%{
    "code" => "IT",
    "name" => "Italy"
    })

{:ok,_cs} =
  AirlinesIpmajor.AirportContext.create_country(%{
    "code" => "NL",
    "name" => "Netherlands"
    })

{:ok,_cs} =
  AirlinesIpmajor.AirportContext.create_country(%{
    "code" => "AT",
    "name" => "Austria"
    })

{:ok, _cs} =
  AirlinesIpmajor.AirportContext.create_city(%{
    "name" => "Lisbon",
    "country_id" => "1"
    })

{:ok, _cs} =
  AirlinesIpmajor.AirportContext.create_city(%{
    "name" => "Porto",
    "country_id" => "1"
    })

{:ok, _cs} =
  AirlinesIpmajor.AirportContext.create_city(%{
    "name" => "Madrid",
    "country_id" => "2"
    })

{:ok, _cs} =
  AirlinesIpmajor.AirportContext.create_city(%{
    "name" => "Brussels",
    "country_id" => "3"
    })

{:ok, _cs} =
  AirlinesIpmajor.AirportContext.create_city(%{
    "name" => "Paris",
    "country_id" => "4"
    })

{:ok, _cs} =
  AirlinesIpmajor.AirportContext.create_city(%{
    "name" => "London",
    "country_id" => "5"
    })

{:ok, _cs} =
  AirlinesIpmajor.AirportContext.create_city(%{
    "name" => "Berlin",
    "country_id" => "6"
    })

{:ok, _cs} =
  AirlinesIpmajor.AirportContext.create_city(%{
    "name" => "Düsseldorf",
    "country_id" => "6"
    })

{:ok, _cs} =
  AirlinesIpmajor.AirportContext.create_city(%{
    "name" => "Rome",
    "country_id" => "7"
    })

{:ok, _cs} =
  AirlinesIpmajor.AirportContext.create_city(%{
    "name" => "Eindhoven",
    "country_id" => "8"
    })

{:ok, _cs} =
  AirlinesIpmajor.AirportContext.create_city(%{
    "name" => "Vienna",
    "country_id" => "9"
    })

{:ok, _cs} =
  AirlinesIpmajor.AirportContext.create_airport(%{
    "code" => "LIS",
    "name" => "Humberto Delgado Airport",
    "city_id" => "1"
    })

{:ok, _cs} =
  AirlinesIpmajor.AirportContext.create_airport(%{
    "code" => "OPO",
    "name" => "Francisco de Sá Carneiro Airport",
    "city_id" => "2"
    })

{:ok, _cs} =
  AirlinesIpmajor.AirportContext.create_airport(%{
    "code" => "MAD",
    "name" => "Madrid-Barajas",
    "city_id" => "3"
    })

{:ok, _cs} =
  AirlinesIpmajor.AirportContext.create_airport(%{
    "code" => "BRU",
    "name" => "Brussels Airport",
    "city_id" => "4"
    })

{:ok, _cs} =
  AirlinesIpmajor.AirportContext.create_airport(%{
    "code" => "CDG",
    "name" => "Charles de Gaulle Airport",
    "city_id" => "5"
    })

{:ok, _cs} =
  AirlinesIpmajor.AirportContext.create_airport(%{
    "code" => "LHR",
    "name" => "London Heathrow Airport",
    "city_id" => "6"
    })

{:ok, _cs} =
  AirlinesIpmajor.AirportContext.create_airport(%{
    "code" => "BER",
    "name" => "Berlin Brandenburg Airport",
    "city_id" => "7"
    })

{:ok, _cs} =
  AirlinesIpmajor.AirportContext.create_airport(%{
    "code" => "DUS",
    "name" => "Düsseldorf Airport",
    "city_id" => "8"
    })

{:ok, _cs} =
  AirlinesIpmajor.AirportContext.create_airport(%{
    "code" => "FCO",
    "name" => "Leonardo da Vinci-Fiumicino Airport",
    "city_id" => "9"
    })

{:ok, _cs} =
  AirlinesIpmajor.AirportContext.create_airport(%{
    "code" => "EIN",
    "name" => "Eindhoven Airport",
    "city_id" => "10"
    })

{:ok, _cs} =
  AirlinesIpmajor.AirportContext.create_airport(%{
    "code" => "VIE",
    "name" => "Vienna International Airport",
    "city_id" => "11"
    })

{:ok, _cs} =
  AirlinesIpmajor.FlightContext.create_flight(%{
    "departure_airport_id" => "1",
    "arrival_airport_id" => "2",
    "price" => "40.50",
    "departure_date" => "2022-06-01",
    "departure_time" => "12:00:00"
    })

{:ok, _cs} =
  AirlinesIpmajor.FlightContext.create_flight(%{
    "departure_airport_id" => "2",
    "arrival_airport_id" => "1",
    "price" => "38.50",
    "departure_date" => "2022-06-01",
    "departure_time" => "16:00:00"
    })


{:ok, _cs} =
  AirlinesIpmajor.UserContext.create_user(%{
    "username" => "admin",
    "email" => "admin@mail.com",
    "password" => "12345678",
    "role" => "Admin",
    "first_name" => "Ad",
    "last_name" => "Min",
    "birthdate" => "1990-09-10",
    "country_id" => "1"
    })

{:ok, _cs} =
  AirlinesIpmajor.UserContext.create_user(%{
    "username" => "user",
    "email" => "user@mail.com",
    "password" => "12345678",
    "role" => "User",
    "first_name" => "Us",
    "last_name" => "Er",
    "birthdate" => "1970-01-01",
    "country_id" => "2"
    })

{:ok, _cs} =
  AirlinesIpmajor.TicketContext.create_ticket(%{
    "user_id" => "1",
    "flight_id" => "1"
    })

{:ok, _cs} =
  AirlinesIpmajor.TicketContext.create_ticket(%{
    "user_id" => "1",
    "flight_id" => "2"
    })

{:ok, _cs} =
  AirlinesIpmajor.EmployeeContext.create_employee(%{
    "first_name" => "John",
    "last_name" => "Doe",
    "birthdate" => "2000-09-08",
    })

{:ok, _cs} =
  AirlinesIpmajor.EmployeeContext.create_employee(%{
    "first_name" => "Joana",
    "last_name" => "Doe",
    "birthdate" => "2000-02-03",
    })

{:ok, _cs} =
  AirlinesIpmajor.CrewMemberContext.create_crew_member(%{
    "employee_id" => "1",
    "flight_id" => "1"
    })

{:ok, _cs} =
  AirlinesIpmajor.CrewMemberContext.create_crew_member(%{
    "employee_id" => "1",
    "flight_id" => "2"
    })
