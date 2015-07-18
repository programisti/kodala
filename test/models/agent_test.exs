defmodule Kodala.AgentTest do
  use Kodala.ModelCase

  alias Kodala.Agent

  @valid_attrs %{country: "some content", rate: 42, username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Agent.changeset(%Agent{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Agent.changeset(%Agent{}, @invalid_attrs)
    refute changeset.valid?
  end
end
