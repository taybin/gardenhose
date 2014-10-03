defmodule Gardenhose.JobTest do
  alias Gardenhose.Model, as: Model
  alias Gardenhose.Repo, as: Repo
  use ExUnit.Case

  test "can save job to database" do
    job = %Model.Job{name: "test"}
    saved_job = Repo.insert(job)
    retrieved_job = Repo.get Model.Job, saved_job.id
    assert retrieved_job.name == job.name
  end

  test "can't save job without name" do
    job = %Model.Job{}
    assert_raise Postgrex.Error, fn ->
      Repo.insert(job)
    end
  end

  test "can't validate job without name" do
    job = %Model.Job{}
    assert Model.Job.validate(job) == [name: "can't be blank"]
  end
end
