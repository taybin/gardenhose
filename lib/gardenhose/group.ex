defmodule Gardenhose.Group do
  use GenServer
  require Logger

  # external
  def job_stopped(group_id, job_id) do
    pid = Gardenhose.Bucket.get(:group_reg, group_id)
    GenServer.cast(pid, {:stopped, job_id})
  end

  def start_link(group_id, first_job) do
    GenServer.start_link(Gardenhose.Group, [group_id, first_job])
  end

  # callbacks
  def init([id, first_job]) do
    Logger.info("started Controller #{id}")
    Gardenhose.Bucket.put(:group_reg, id, self())
    :ok = GenEvent.add_handler(:job_stream, Gardenhose.Group.Listener, [id])
    {:ok, %{id: id}}
  end

  def terminate(reason, state) do
    GenEvent.remove_handler(:job_stream, Gardenhose.Group.Listener, [])
    Gardenhose.Bucket.delete(:group_reg, state.id)
    :ok
  end

  def handle_cast({:start_job, args}, state) do
    {:ok, pid} = Gardenhose.Job.create_job(args)
    Gardenhose.Job.start(pid, :parent)
    {:noreply, state}
  end

  def handle_cast({:stopped, job_id}, state) do
    Logger.debug("job stopped, #{job_id}")
    {:noreply, state}
  end

  # private
  defp lookup_job(job_id) do

  end

  defmodule Listener do
    use GenEvent
    require Logger

    def init(group_id) do
      Logger.info("started listener")
      {:ok, %{group_id: group_id}}
    end

    def handle_event({:stop, group_id, job_id}, state) do
      if state.group_id == group_id do
        Gardenhose.Group.job_stopped(group_id, job_id)
      end
      {:ok, state}
    end

    def handle_event(_, state), do: {:ok, state}
  end
end
