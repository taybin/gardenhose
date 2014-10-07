defmodule Gardenhose.Plugin.Script do
  use GenServer
  require Logger

  ##
  # External
  #
  def add_plugin(name, stateFn) do
    Gardenhose.Plugin.Script.Supervisor.add_plugin(name, stateFn)
  end

  def start_link(name, stateFn) do
    GenServer.start_link(__MODULE__, [stateFn], [name: name])
  end

  def start(name) do
    GenServer.cast(name, {:start, :os.getpid()})
  end

  ##
  # Internal
  #

  def init([stateFn]) do
    {:ok, stateFn.()}
  end

  def handle_cast({:start, parent_id}, state) do
    Logger.info("here we go")
    {:noreply, state}
  end
end
