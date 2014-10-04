defmodule Gardenhose.Plugin.RegistryTest do
  alias Gardenhose.Plugin.Registry, as: Registry
  use ExUnit.Case, async: true

  setup do
    {:ok, registry} = Registry.start_link(name: :reg)
    {:ok, registry: registry}
  end

  test "stores values by key", %{registry: registry} do
    assert Registry.get(registry, "milk") == nil

    Registry.put(registry, "milk", 3)
    assert Registry.get(registry, "milk") == 3
  end
end
