# This file is responsible for configuring your application
use Mix.Config

# Note this file is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project.

config :phoenix, Gardenhose.Router,
  port: System.get_env("PORT"),
  ssl: false,
  static_assets: true,
  cookies: true,
  session_key: "_gardenhose_key",
  session_secret: "35*&R38=TRK(Z454!Q((CI#T0W&X1R^X0F41@^37VU%H1=N$U4HYKL!@NT8C11!6DGENQ$+",
  catch_errors: true,
  debug_errors: false,
  error_controller: Gardenhose.PageController

config :phoenix, :code_reloader,
  enabled: false

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. Note, this must remain at the bottom of
# this file to properly merge your previous config entries.
import_config "#{Mix.env}.exs"
