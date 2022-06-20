import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :airlines_ipmajor, AirlinesIpmajor.Repo,
  username: "root",
  password: "",
  hostname: "localhost",
  database: "airlines_ipmajor_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :airlines_ipmajor_web, AirlinesIpmajorWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "X/pJNnEkvMW1rQBPu/ZYzVpjFl4c0iyiBgXLgox6dO/eU7pgGsyZ2gewnHmb8Glt",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# In test we don't send emails.
config :airlines_ipmajor, AirlinesIpmajor.Mailer, adapter: Swoosh.Adapters.Test

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
