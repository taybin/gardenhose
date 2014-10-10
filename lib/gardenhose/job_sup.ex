defmodule Gardenhose.Job.Supervisor do
  use Supervisor

  def create_job(args) do
    Supervisor.start_child(:job_sup, [args])
  end

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: :job_sup)
  end

  def init([]) do
    children = [
      worker(Gardenhose.Job, [], restart: :temporary)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
