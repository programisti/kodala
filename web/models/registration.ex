defmodule Kodala.Registration do
  import Ecto.Changeset, only: [put_change: 3]
  alias Kodala.Repo

  def create(changeset) do
    changeset
    |> put_change(:encrypted_password, encrypt(changeset.params["password"]))
    |> Repo.insert()
  end

  defp encrypt(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end
end
