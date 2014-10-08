defmodule Gardenhose.Job.Master do
  defmodule Listener do
    use GenEvent

    def handle_event({:stop, args}) do
      Controller.job_stopped(args)
    end
  end

  defmodule Controller do
    use GenServer
    require Logger

    def job_stopped(args) do
      GenServer.cast(:job_master, {:stopped, args})
    end

    def start_link do
      GenServer.start_link(__MODULE__, [], name: :job_master)
    end

    def init([]) do
      GenEvent.add_handler(:job_stream, Listener, :stop)
      {:ok, []}
    end

    def handle_cast({:stopped, args}, state) do
      Logger.info("job stopped here")
    end
  end
end
