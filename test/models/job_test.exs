defmodule Kodala.JobTest do
  use Kodala.ModelCase

  alias Kodala.Job

  @valid_attrs %{description: "some content", end_time: %{hour: 14, min: 0}, start_time: %{hour: 14, min: 0}, title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Job.changeset(%Job{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Job.changeset(%Job{}, @invalid_attrs)
    refute changeset.valid?
  end
end
