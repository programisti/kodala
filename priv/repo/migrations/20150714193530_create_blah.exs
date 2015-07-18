defmodule Kodala.Repo.Migrations.CreateBlah do
  use Ecto.Migration

  def change do
    create table(:blahs) do
      add :param1, :string
      add :param2, :string

      timestamps
    end

  end
end
