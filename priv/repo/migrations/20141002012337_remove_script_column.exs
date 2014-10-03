defmodule Gardenhose.Repo.Migrations.RemoveScriptColumn do
  use Ecto.Migration

  def up do
    "ALTER TABLE jobs DROP COLUMN script"
  end

  def down do
    "ALTER TABLE jobs ADD COLUMN script TEXT"
  end
end
