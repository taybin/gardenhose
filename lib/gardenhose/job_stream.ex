defmodule Gardenhose.Job.Stream do
  require Logger

  @spec notify_start(integer, integer) :: :ok
  def notify_start(group_id, run_id) do
    GenEvent.sync_notify(:job_stream, {:start, group_id, run_id})
  end

  @spec notify_stop(integer, integer, Gardenhose.Job.result) :: :ok
  def notify_stop(group_id, run_id, result) do
    GenEvent.sync_notify(:job_stream, {:stop, group_id, run_id})
  end

  @spec start_link() :: GenEvent.on_start
  def start_link do
    GenEvent.start_link(name: :job_stream)
  end
end
