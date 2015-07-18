defmodule Kodala.Repo.Migrations.CreateAgent do
  use Ecto.Migration

  def change do
    create table(:agents) do
      add :username, :string
      add :country, :string
      add :rate, :integer
      add :ecrypted_password, :string

      timestamps
    end

  end
end
