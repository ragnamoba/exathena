{:ok, _} = :application.ensure_all_started(:exathena)

# Start Faker
Faker.start()

# Start the tests
ExUnit.start()

# Changes database mode to manula
Ecto.Adapters.SQL.Sandbox.mode(ExAthena.Repo, :manual)
