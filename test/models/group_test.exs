defmodule Gardenhose.GroupTest do
  alias Gardenhose.Model.Group, as: Group
  alias Gardenhose.Repo, as: Repo
  use ExUnit.Case

  test "can save group to database" do
    group = %Group{name: "test"}
    saved_group = Repo.insert(group)
    retrieved_group = Repo.get Group, saved_group.id
    assert retrieved_group.name == group.name
  end

  test "can't save group without name" do
    group = %Group{}
    assert_raise Postgrex.Error, fn ->
      Repo.insert(group)
    end
  end

  test "can't validate group without name" do
    group = %Group{}
    assert Group.validate(group) == [name: "can't be blank"]
  end
end
