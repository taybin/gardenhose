defmodule Gardenhose.Model.Job do
  use Ecto.Model

  schema "jobs" do
    field :name, :string
    field :script, :string
  end

  validate job,
      name: present()
end
