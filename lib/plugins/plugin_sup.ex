defmodule Gardenhose.Plugin.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  @registry_name Gardenhose.Plugin.Registry

  def init([]) do
    children = [
      worker(Gardenhose.Plugin.Registry, [[name: @registry_name]])
    ]
    supervise(children, strategy: :one_for_one)
  end

  def add_plugin_sup(sup) do
    Supervisor.start_child(__MODULE__, sup)
  end

end
