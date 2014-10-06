defmodule Gardenhose.Plugin.Script do
  use GenServer
  require Logger

  ##
  # External
  #
  def start_link(stateFn) do
    GenServer.start_link(__MODULE__, stateFn)
  end

  def start(pid) do
    GenServer.cast(pid, {:start, :os.getpid()})
  end

  ##
  # Internal
  #

  def init(stateFn) do
    {:ok, stateFn.()}
  end

  def handle_cast({:start, parent_id}, state) do
    Logger.info("here we go")
    {:noreply, state}
  end
end
