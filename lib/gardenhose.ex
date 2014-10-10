defmodule Gardenhose do
  use Application
  require Logger

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Logger.info "Starting Gardenhose"

    children = [
      # Define workers and child supervisors to be supervised
      worker(Gardenhose.Repo, []),
      worker(Gardenhose.Job.Stream, []),
      supervisor(Gardenhose.Job.Supervisor, []),
      worker(Gardenhose.Job.Master.Controller, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gardenhose.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
