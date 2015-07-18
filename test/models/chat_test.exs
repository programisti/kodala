defmodule Kodala.ChatTest do
  use Kodala.ModelCase

  alias Kodala.Chat

  @valid_attrs %{agent: nil, client_hash: "some content", client_name: "some content", status: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Chat.changeset(%Chat{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Chat.changeset(%Chat{}, @invalid_attrs)
    refute changeset.valid?
  end
end
