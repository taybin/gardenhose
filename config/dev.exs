use Mix.Config

config :phoenix, Gardenhose.Router,
  port: System.get_env("PORT") || 4000,
  ssl: false,
  host: "localhost",
  cookies: true,
  session_key: "_gardenhose_key",
  session_secret: "35*&R38=TRK(Z454!Q((CI#T0W&X1R^X0F41@^37VU%H1=N$U4HYKL!@NT8C11!6DGENQ$+",
  debug_errors: true

config :phoenix, :code_reloader,
  enabled: true

config :logger, :console,
  level: :debug


