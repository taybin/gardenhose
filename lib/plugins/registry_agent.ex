defmodule Gardenhose.Plugin.Registry do
  @doc """
  Starts a new registry.
  """
  def start_link(default) do
    Agent.start_link(fn -> HashDict.new end, default)
  end

  @doc """
  Gets a value from the `registry` by `key`.
  """
  def get(registry, key) do
    Agent.get(registry, &HashDict.get(&1, key))
  end

  @doc """
  Puts the `value` for the given `key` in the `registry`.
  """
  def put(registry, key, value) do
    Agent.update(registry, &HashDict.put(&1, key, value))
  end
end
