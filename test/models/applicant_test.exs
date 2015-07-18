defmodule Kodala.ApplicantTest do
  use Kodala.ModelCase

  alias Kodala.Applicant

  @valid_attrs %{motivation: "some content", rate: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Applicant.changeset(%Applicant{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Applicant.changeset(%Applicant{}, @invalid_attrs)
    refute changeset.valid?
  end
end
