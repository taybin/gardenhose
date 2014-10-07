defmodule Gardenhose.Plugin.Script.Supervisor do
  use Supervisor

  def add_plugin(name, stateFn) do
    Supervisor.start_child(__MODULE__, [name, stateFn])
  end

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init([]) do
    children = [
      worker(Gardenhose.Plugin.Script, [])
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
