defmodule Gardenhose.Model.JobTest do
  alias Gardenhose.Model.Job, as: Job
  alias Gardenhose.Model.JobToJob, as: JobToJob
  alias Gardenhose.Repo, as: Repo
  use ExUnit.Case, async: true

  test "can save job to database" do
    job = %Job{name: "test"}
    saved_job = Repo.insert(job)
    retrieved_job = Repo.get Job, saved_job.id
    assert retrieved_job.name == job.name
  end

  test "can't save job without name" do
    job = %Job{}
    assert_raise Postgrex.Error, fn ->
      Repo.insert(job)
    end
  end

  test "can't validate job without name" do
    job = %Job{}
    assert Job.validate(job) == [name: "can't be blank"]
  end

  test "can have childen and parents" do
    job1 = %Job{name: "parent"} |> Repo.insert
    job2 = %Job{name: "child2"} |> Repo.insert
    %JobToJob{parent_id: job1.id, child_id: job2.id} |> Repo.insert
    assert Job.get_children(job1) == [job2]
    assert Job.get_parents(job2) == [job1]
  end
end
