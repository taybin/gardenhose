defmodule Gardenhose.Model.JobToJob do
  alias Gardenhose.Model.Job, as: Job
  use Ecto.Model

  schema "job_to_job", primary_key: false do
    belongs_to :parent, Job, foreign_key: :parent_id
    belongs_to :child, Job, foreign_key: :child_id
  end
end
