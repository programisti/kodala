defmodule Kodala.RequestTest do
  use Kodala.ModelCase

  alias Kodala.Request

  @valid_attrs %{accepeted: true, description: "some content", rate: 42, status: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Request.changeset(%Request{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Request.changeset(%Request{}, @invalid_attrs)
    refute changeset.valid?
  end
end
