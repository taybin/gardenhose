defmodule Gardenhose.GroupTest do
  use ExUnit.Case, async: true


  test "Group should properly init and register in bucket" do
    group_id = 1
    {:ok, state} = Gardenhose.Group.init([group_id, 2])
    assert state.id == group_id
    assert Gardenhose.Bucket.get(:group_reg, group_id) == self()
  end

  test "Group should properly terminate and deregister from bucket" do
    group_id = 1
    Gardenhose.Bucket.put(:group_reg, group_id, 2)
    :ok = Gardenhose.Group.terminate(:normal, %{id: group_id})
    assert Gardenhose.Bucket.get(:group_reg, group_id) == nil
  end
end
