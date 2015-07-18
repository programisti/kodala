# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :kodala, Kodala.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "souoaMwQ5g73x6REOYUAXfuTTw1d80C2RDeIEoS6ogtHs8mKiPHIWmILAb8S0mn/",
  debug_errors: false,
  pubsub: [name: Kodala.PubSub,
           adapter: Phoenix.PubSub.Redis,
             host: "127.0.0.1"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]


#config :phoenix, :template_engines,
    #haml: PhoenixHaml.Engine

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
