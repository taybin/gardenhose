defmodule Gardenhose.Job.Stream do
  require Logger

  def notify_start(group_id, job_id) do
    GenEvent.sync_notify(:job_stream, {:start, group_id, job_id})
  end

  def notify_stop(group_id, job_id) do
    GenEvent.sync_notify(:job_stream, {:stop, group_id, job_id})
  end

  def start_link do
    GenEvent.start_link(name: :job_stream)
  end
end
