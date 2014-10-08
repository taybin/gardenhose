defmodule Gardenhose.Job.Stream do
  def notify_start(args) do
    GenEvent.sync_notify(:job_stream, {:start, args})
  end

  def notify_stop(args) do
    GenEvent.sync_notify(:job_stream, {:stop, args})
  end

  def start_link() do
    GenEvent.start_link(name: :job_stream)
  end
end
