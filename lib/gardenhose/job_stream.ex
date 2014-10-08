defmodule Gardenhose.Job.Stream do
  require Logger

  def notify_start(args) do
    GenEvent.sync_notify(:job_stream, {:start, args})
  end

  def notify_stop(args) do
    Logger.warn("stopping event 1")
    GenEvent.sync_notify(:job_stream, {:stop, args})
    Logger.warn("stopping event 2")
  end

  def start_link() do
    GenEvent.start_link(name: :job_stream)
  end
end
