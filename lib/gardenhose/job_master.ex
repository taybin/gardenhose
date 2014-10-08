defmodule Gardenhose.Job.Master do
  defmodule Listener do
    use GenEvent
    require Logger

    def init(args) do
      Logger.info("started listener")
      {:ok, args}
    end

    def handle_event({:start, _}, state) do
      {:ok, state}
    end

    def handle_event({:stop, args}, state) do
      Logger.info("handle_event stop")
      Gardenhose.Job.Master.Controller.job_stopped(args)
      {:ok, state}
    end
  end

  defmodule Controller do
    use GenServer
    require Logger

    def start_job(args) do
      GenServer.cast(:job_master, {:start_job, args})
    end

    def job_stopped(args) do
      GenServer.cast(:job_master, {:stopped, args})
    end

    def start_link do
      GenServer.start_link(__MODULE__, [], name: :job_master)
    end

    def init do
      {:ok, []}
    end

    def handle_cast({:start_job, args}, state) do
      Logger.info("started Controller")
      GenEvent.add_handler(:job_stream, Gardenhose.Job.Master.Listener, [:hi])
      {:ok, pid} = Gardenhose.Job.create_job(args)
      Gardenhose.Job.start(pid, :parent)
      {:noreply, state}
    end

    def handle_cast({:stopped, args}, state) do
      Logger.info("job stopped here")
      {:noreply, state}
    end
  end
end
