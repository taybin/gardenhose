defmodule Gardenhose.Model.Job do
  alias Gardenhose.Model.JobToJob, as: JobToJob
  use Ecto.Model
  import Ecto.Query, only: [from: 2]

  schema "jobs" do
    field :name, :string
    has_many :children, JobToJob, foreign_key: :parent_id
    has_many :parents, JobToJob, foreign_key: :child_id
  end

  validate job,
      name: present()

  def get_children(job) do
    from(j in Gardenhose.Model.Job,
         join: j2j in JobToJob, on: j.id == j2j.parent_id,
         inner_join: j1 in Gardenhose.Model.Job, on: j1.id == j2j.child_id,
         select: j1,
         where: j.id == ^job.id)
    |> Gardenhose.Repo.all
  end

  def get_parents(job) do
    from(j in Gardenhose.Model.Job,
         join: j2j in JobToJob, on: j.id == j2j.child_id,
         inner_join: j1 in Gardenhose.Model.Job, on: j1.id == j2j.parent_id,
         select: j1,
         where: j.id == ^job.id)
    |> Gardenhose.Repo.all
  end
end
