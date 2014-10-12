defmodule Gardenhose.Job do
  use GenServer
  require Logger

  defmodule State do
    defstruct id: nil, group_id: nil, fun: nil, parents: [], wait_for_parents: false
    @type t :: %State{
      id: integer,
      group_id: integer,
      fun: (() -> :ok | {:error, any}),
      parents: [integer],
      wait_for_parents: boolean
    }
  end

  def create_job(id, group_id, fun, opts \\ []) do
    Gardenhose.Job.Supervisor.create_job(id, group_id, fun, opts)
  end

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def start(pid, caller) do
    GenServer.cast(pid, {:start, caller})
  end

  def init([id, group_id, fun, opts]) do
    {:ok, %State{id: id, group_id: group_id, fun: fun, wait_for_parents: opts[:wait_for_parents], parents: opts[:parents]}}
  end

  def handle_cast({:start, caller}, state) do
    Logger.info("Job started")
    Gardenhose.Job.Stream.notify_start(state.group_id, state.id)
    state.fun.()
    Gardenhose.Job.Stream.notify_stop(state.group_id, state.id)
    Logger.info("Job ended")
    {:stop, :normal, state}
  end
end
