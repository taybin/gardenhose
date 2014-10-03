defmodule Gardenhose.Repo.Migrations.AddGroupTable do
  use Ecto.Migration

  def up do
    "CREATE TABLE IF NOT EXISTS groups(id SERIAL PRIMARY KEY, name TEXT NOT NULL, job_id INTEGER REFERENCES jobs(id))"
  end

  def down do
    "DROP TABLE groups"
  end
end
