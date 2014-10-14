defmodule Gardenhose.JobTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = Gardenhose.Bucket.start_link(name: :test_job)
    {:ok, bucket: bucket}
  end

  test "should run function on start", %{bucket: bucket} do
    test_pid = self()
    fun = fn(_) ->
      send test_pid, :ran
      :ok
    end

    {:ok, pid} = Gardenhose.Job.create_job(1, 2, 3, fun)
    Gardenhose.Job.start(pid, 4)
    assert_receive :ran
  end

  test "should pass json to function" do
    test_pid = self()
    fun = fn(data) ->
      send test_pid, {:ran, data}
      :ok
    end

    data = %{ran: true}
    {:ok, pid} = Gardenhose.Job.create_job(1, 2, 3, fun, data: data)
    Gardenhose.Job.start(pid, 4)
    assert_receive {:ran, ^data}
  end

  test "should wait for all parents before running function" do
    test_pid = self()
    fun = fn(_) ->
      send test_pid, :ran
      :ok
    end

    {:ok, pid} = Gardenhose.Job.create_job(1, 2, 3, fun, wait_for_parents: [4, 5])
    Gardenhose.Job.start(pid, 4)
    refute_receive :ran
    Gardenhose.Job.start(pid, 5)
    assert_receive :ran
  end

end
