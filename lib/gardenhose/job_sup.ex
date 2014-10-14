defmodule Gardenhose.Job.Supervisor do
  alias Gardenhose.Job, as: Job
  use Supervisor

  @spec create_job(integer, integer, integer, Job.job_fun, Job.options) :: Supervisor.on_start_child
  def create_job(run_id, job_id, group_id, fun, opts) do
    Supervisor.start_child(:job_sup, [run_id, job_id, group_id, fun, opts])
  end

  @spec start_link() :: Supervisor.on_start
  def start_link do
    Supervisor.start_link(__MODULE__, [], name: :job_sup)
  end

  def init([]) do
    children = [
      worker(Job, [], restart: :temporary)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
