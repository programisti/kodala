use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :kodala, Kodala.Endpoint,
  secret_key_base: "Z52pP5wMSEEJ3kdwmM30VpE2+QKUnFXo0XKC9laIdQFK5WNiQEI/O2FgK9EH+Xnh"

# Configure your database
config :kodala, Kodala.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "kodala_prod",
  size: 20 # The amount of database connections in the pool
