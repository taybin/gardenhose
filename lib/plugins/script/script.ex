defmodule Gardenhose.Plugin.Script do
  use GenServer
  require Logger

  def init(args) do
    {:ok, []}
  end

  def handle_cast({:start, parent_id}, state) do
    Logger.warn("here we go")
    {:noreply, [parent_id|state]}
  end
end
