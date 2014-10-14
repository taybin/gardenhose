defmodule Gardenhose.BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = Gardenhose.Bucket.start_link(name: :test_bucket)
    {:ok, bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert Gardenhose.Bucket.get(bucket, "milk") == nil

    Gardenhose.Bucket.put(bucket, "milk", 3)
    assert Gardenhose.Bucket.get(bucket, "milk") == 3
  end

  test "delete values", %{bucket: bucket} do
    assert Gardenhose.Bucket.get(bucket, "milk") == nil
    Gardenhose.Bucket.put(bucket, "milk", 3)
    assert Gardenhose.Bucket.get(bucket, "milk") == 3
    Gardenhose.Bucket.delete(bucket, "milk")
    assert Gardenhose.Bucket.get(bucket, "milk") == nil
  end

  test "clear values", %{bucket: bucket} do
    Gardenhose.Bucket.put(bucket, "milk", 3)
    Gardenhose.Bucket.put(bucket, "cheese", 4)
    Gardenhose.Bucket.clear(bucket)
    assert Gardenhose.Bucket.get(bucket, "milk") == nil
    assert Gardenhose.Bucket.get(bucket, "cheese") == nil
  end
end
