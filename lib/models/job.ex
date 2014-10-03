defmodule Gardenhose.Model.Job do
  use Ecto.Model

  schema "jobs" do
    field :name, :string
  end

  validate job,
      name: present()
end
