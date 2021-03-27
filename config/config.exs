# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :hui,
  ecto_repos: [Hui.Repo]

# Configures the endpoint
config :hui, HuiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7+jSIZ/+aVGQcHll2z6TAl9XRbPTZ5nRxwMKcY4UGcEK5Ogep+8n/StUKbDiNveR",
  render_errors: [view: HuiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Hui.PubSub,
  live_view: [signing_salt: "Qwi5mbhP"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :bcrypt_elixir, :log_rounds, 10

config :hui, Hui.Guardian,
  issuer: "hui",
  secret_key: "3LPLKOzmTGl5hpJ6CRQ1peJxbylmJRuM+XiAgWAuWvUmMCXZQldNUJyC5KlrNV8y"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
