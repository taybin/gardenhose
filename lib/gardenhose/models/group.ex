defmodule Gardenhose.Model.Group do
  alias Gardenhose.Model.Job, as: Job
  use Ecto.Model

  schema "groups" do
    field :name, :string
    has_one :job, Job
  end

  validate group,
      name: present()
end
