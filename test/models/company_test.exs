defmodule Kodala.CompanyTest do
  use Kodala.ModelCase

  alias Kodala.Company

  @valid_attrs %{username: "some content", website: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Company.changeset(%Company{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Company.changeset(%Company{}, @invalid_attrs)
    refute changeset.valid?
  end
end
