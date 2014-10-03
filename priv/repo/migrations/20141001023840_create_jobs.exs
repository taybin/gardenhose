defmodule Gardenhose.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def up do
    "CREATE TABLE IF NOT EXISTS jobs(id SERIAL PRIMARY KEY, name TEXT NOT NULL, script TEXT)"
  end

  def down do
    "DROP TABLE jobs"
  end
end
