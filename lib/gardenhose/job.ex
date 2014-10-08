defmodule Gardenhose.Job do
  use GenServer

  def start_link(args) do
    GenServer.start(__MODULE__, args)
  end

  def start(pid, caller) do
    GenServer.cast(pid, {:start, caller})
  end

  def init(args) do
    {:ok, args}
  end

  def handle_cast({:start, caller}, state) do
    {:noreply, state}
  end
end
