import Config

# Configures the application
config :exathena,
  clock_module: ExAthena.ClockMock,
  logger_adapter: ExAthenaLoggerMock

# Configure your database
config :exathena, ExAthena.Repo,
  username: "postgres",
  password: "postgres",
  database: "exathena_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :exathena, ExAthenaWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  server: false

# In test we don't send emails.
config :exathena, ExAthena.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
