defmodule Gardenhose.Model.Group do
  alias Gardenhose.Model, as: Model
  use Ecto.Model

  schema "groups" do
    field :name, :string
    has_one :job, Model.Job
  end

  validate group,
      name: present()
end
