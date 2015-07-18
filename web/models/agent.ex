defmodule Kodala.Agent do
  use Kodala.Web, :model

  schema "agents" do
    field :username, :string
    field :country, :string
    field :rate, :integer
    field :encrypted_password, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    has_many :chats, Kodala.Chat

    timestamps
  end

  @required_fields ~w(username country rate)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
