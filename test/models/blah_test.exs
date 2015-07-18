defmodule Kodala.BlahTest do
  use Kodala.ModelCase

  alias Kodala.Blah

  @valid_attrs %{param1: "some content", param2: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Blah.changeset(%Blah{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Blah.changeset(%Blah{}, @invalid_attrs)
    refute changeset.valid?
  end
end
