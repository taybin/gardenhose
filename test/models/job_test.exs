defmodule JobTest do
  use ExUnit.Case

  test "can save job to database" do
    job = %Gardenhose.Model.Job{name: "test"}
    saved_job = Repo.insert(job)
    retrieved_job = Repo.get Gardenhose.Model.Job, saved_job.id
    assert retrieved_job.name == job.name
  end

  test "can't save job without name" do
    job = %Gardenhose.Model.Job{script: "test"}
    assert_raise Postgrex.Error, fn ->
      Repo.insert(job)
    end
  end

  test "can't validate job without name" do
    job = %Gardenhose.Model.Job{script: "test"}
    assert Gardenhose.Model.Job.validate(job) == [name: "can't be blank"]
  end
end
