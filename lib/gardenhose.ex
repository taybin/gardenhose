defmodule Gardenhose do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      # worker(TestApp.Worker, [arg1, arg2, arg3])
      worker(Gardenhose.Repo, []),
      supervisor(Gardenhose.Plugin.Supervisor, [])
    ]

    opts = [strategy: :one_for_one, name: Gardenhose.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
