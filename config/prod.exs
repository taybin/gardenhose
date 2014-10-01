use Mix.Config

# NOTE: To get SSL working, you will need to set:
#
#     ssl: true,
#     keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#     certfile: System.get_env("SOME_APP_SSL_CERT_PATH"),
#
# Where those two env variables point to a file on disk
# for the key and cert

config :phoenix, Gardenhose.Router,
  port: System.get_env("PORT"),
  ssl: false,
  host: "example.com",
  cookies: true,
  session_key: "_gardenhose_key",
  session_secret: "35*&R38=TRK(Z454!Q((CI#T0W&X1R^X0F41@^37VU%H1=N$U4HYKL!@NT8C11!6DGENQ$+"

config :logger, :console,
  level: :info,
  metadata: [:request_id]

