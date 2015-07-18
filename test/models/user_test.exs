defmodule Kodala.UserTest do
  use Kodala.ModelCase

  alias Kodala.User

  @valid_attrs %{encrypted_password: "some content", type: "some content", username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
