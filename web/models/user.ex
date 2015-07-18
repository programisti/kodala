defmodule Kodala.User do
  use Kodala.Web, :model

  schema "users" do
    field :type, :string
    field :email, :string
    field :encrypted_password, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps
  end

  @required_fields ~w(email password password_confirmation)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_unique(:email, on: Kodala.Repo, downcase: true)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password_confirmation, min: 5)
  end
  

end
