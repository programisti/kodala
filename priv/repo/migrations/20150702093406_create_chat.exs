defmodule Kodala.Repo.Migrations.CreateChat do
  use Ecto.Migration

  def change do
    create table(:chats) do
      add :client_name, :string
      add :client_hash, :string
      add :status, :string
      add :room, :string
      add :ip_address, :string
      add :agent_id, :integer

      timestamps
    end
    create index(:chats, [:agent_id])

  end
end
