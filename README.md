# AirlinesIpmajor.Umbrella

## Start Phoenix server

- Copy the file dev.exs.example inside the config folder and remove the ".example" from the file name
- Change in this new dev.exs file the database config
- Install dependencies with `mix deps.get` in root directory
- Create or reset database with `mix ecto.reset` in apps/airlines_ipmajor/
- Start Phoenix inside IEx with `iex -S mix phx.server` in the root directory

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Thema: Airlines website

### Database schema:

![ERD van database](Database%20schema/ipmajor_airlines_erd.png)

### Many to Many

User - Flight (association table is Ticket)

# API

## Public API

Available requests:

- GET /api/flights
- GET /api/flights/id
- GET /api/airports
- GET /api/airports/id
- GET /api/cities
- GET /api/cities/id
- GET /api/countries
- GET /api/countries/id

## Private API

To send API requests to the private API, you need to provide your account's API key generated in the user area (website), and set it as a **x-api-key** header field.

Available requests:

- GET /api/user-tickets