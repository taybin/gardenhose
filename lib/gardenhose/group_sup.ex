defmodule Gardenhose.Group.Supervisor do
  use Supervisor

  def create_group(id, first_job) do
    Supervisor.start_child(:group_sup, [id, first_job])
  end

  @spec start_link() :: Supervisor.on_start
  def start_link do
    Supervisor.start_link(__MODULE__, [], [])
  end

  def init([]) do
    children = [
      worker(Gardenhose.Group, [], restart: :temporary)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
