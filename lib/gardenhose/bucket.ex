defmodule Gardenhose.Bucket do
  @doc """
  Starts a new bucket.
  """
  def start_link(options) do
    Agent.start_link(fn -> HashDict.new end, options)
  end

  @doc """
  Gets a value from the `bucket` by `key`.
  """
  def get(bucket, key) do
    Agent.get(bucket, &HashDict.get(&1, key))
  end

  @doc """
  Puts the `value` for the given `key` in the `bucket`.
  """
  def put(bucket, key, value) do
    Agent.update(bucket, &HashDict.put(&1, key, value))
  end

  @doc """
  Deletes `key` from `bucket`.

  Returns the current value of `key`, if `key` exists.
  """
  def delete(bucket, key) do
    Agent.get_and_update(bucket, &HashDict.pop(&1, key))
  end

  @doc """
  Clear all keys from `bucket`.

  Returns nil
  """
  def clear(bucket) do
    Agent.update(bucket, fn (_) -> HashDict.new end)
  end
end
