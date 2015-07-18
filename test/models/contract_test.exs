defmodule Kodala.ContractTest do
  use Kodala.ModelCase

  alias Kodala.Contract

  @valid_attrs %{rate: 42, status: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Contract.changeset(%Contract{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Contract.changeset(%Contract{}, @invalid_attrs)
    refute changeset.valid?
  end
end
