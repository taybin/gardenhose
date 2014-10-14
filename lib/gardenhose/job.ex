defmodule Gardenhose.Job do
  use GenServer
  require Logger

  defmodule State do
    defstruct run_id: nil,
              job_id: nil,
              group_id: nil,
              job_fun: nil,
              parents: nil,
              wait_for_parents: nil,
              finished_parents: HashSet.new,
              fun_data: nil

    @type t :: %State{
      run_id: integer,
      job_id: integer,
      group_id: integer,
      job_fun: ((Poison.Parser.t) -> :ok | {:error, any}),
      parents: HashSet.t | nil,
      wait_for_parents: boolean,
      finished_parents: HashSet.t,
      fun_data: Poison.Parser.t
    }
  end

  @type options :: [
    {:wait_for_parents, [integer]},
    {:data, Poison.Parser.t}
  ]

  @type result :: :ok | {:error, any}

  @type job_fun :: ((Poison.Parser.t) -> result)

  @spec create_job(integer, integer, integer, job_fun, options) :: Supervisor.on_start
  def create_job(run_id, job_id, group_id, job_fun, opts \\ []) do
    Gardenhose.Job.Supervisor.create_job(run_id, job_id, group_id, job_fun, opts)
  end

  def start_link(run_id, job_id, group_id, job_fun, opts) do
    GenServer.start_link(__MODULE__, [run_id, job_id, group_id, job_fun, opts])
  end

  def start(pid, parent_id) do
    GenServer.cast(pid, {:start, parent_id})
  end

  def init([run_id, job_id, group_id, job_fun, opts]) do
    wait_for_parents = Keyword.has_key?(opts, :wait_for_parents)
    parents = !wait_for_parents || Enum.into(Keyword.get(opts, :wait_for_parents), HashSet.new)

    {:ok, %State{
        run_id: run_id,
        job_id: job_id,
        group_id: group_id,
        job_fun: job_fun,
        wait_for_parents: wait_for_parents,
        parents: parents,
        fun_data: Keyword.get(opts, :data)
      }
    }
  end

  def handle_cast({:start, parent_id}, %State{wait_for_parents: true} = state) do
    new_parents = HashSet.put(state.finished_parents, parent_id)
    state = %{state | finished_parents: new_parents}
    if HashSet.equal?(state.finished_parents, state.parents) do
      run(state)
      {:stop, :normal, state}
    else
      {:noreply, state}
    end
  end

  def handle_cast({:start, _parent_id}, state) do
    run(state)
    {:stop, :normal, state}
  end

  @spec run(State.t) :: result
  defp run(state) do
    Logger.info("Job started")
    Gardenhose.Job.Stream.notify_start(state.group_id, state.run_id)
    result = state.job_fun.(state.fun_data)
    Gardenhose.Job.Stream.notify_stop(state.group_id, state.run_id, result)
    Logger.info("Job ended")
    result
  end
end
