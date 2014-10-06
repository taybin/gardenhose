defmodule Gardenhose.Plugin.Supervisor do
  use Supervisor

  @plugin_sup_name Gardenhose.Plugin.Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: @plugin_sup_name)
  end

  def init([]) do
    children = [
    ]
    supervise(children, strategy: :one_for_one)
  end

  def add_plugin_sup(sup) do
    spec = supervisor(sup, [])
    Supervisor.start_child(@plugin_sup_name, spec)
  end

end
