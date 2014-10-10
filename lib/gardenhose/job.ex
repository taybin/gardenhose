defmodule Gardenhose.Job do
  use GenServer
  require Logger

  def create_job(args) do
    Gardenhose.Job.Supervisor.create_job(args)
  end

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def start(pid, caller) do
    GenServer.cast(pid, {:start, caller})
  end

  def init(args) do
    {:ok, args}
  end

  def handle_cast({:start, caller}, state) do
    Logger.info("Job started")
    Gardenhose.Job.Stream.notify_start(:a)
    state.()
    Gardenhose.Job.Stream.notify_stop(:b)
    Logger.info("Job ended")
    {:stop, :normal, state}
  end
end
