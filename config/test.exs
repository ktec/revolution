use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :revolution, Revolution.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :revolution, Revolution.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "revolution_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
