defmodule Gardenhose.Repo.Migrations.AddJobToJobTable do
  use Ecto.Migration

  def up do
    "CREATE TABLE IF NOT EXISTS job_to_job(parent_id INTEGER NOT NULL REFERENCES jobs(id) ON DELETE CASCADE, child_id INTEGER NOT NULL REFERENCES jobs(id) ON DELETE CASCADE)"
  end

  def down do
    "DROP TABLE job_to_job"
  end
end
