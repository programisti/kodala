defmodule Kodala.Chat do
  use Kodala.Web, :model
  require Logger
  alias Kodala.Chat
  alias Kodala.Repo

  schema "chats" do
    field :client_name, :string
    field :client_hash, :string
    field :status, :string
    field :room, :string
    field :ip_address, :string

    belongs_to :agent, Kodala.Agent

    timestamps
  end

  @required_fields ~w(client_name client_hash status)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def get(id) do
    Repo.get!(Chat, id)
  end

  def create(client_name, room, ip) do
    params = %Chat{ client_name: client_name, 
                    client_hash: client_name, 
                    ip_address: ip, 
                    status: "entered", 
                    room: room}
    Repo.insert! params
  end

  def add_agent(id, agent) do
    chat = Repo.get!(Chat, id)
    
    cond do
      chat.status == "entered" -> 
        chat = %{chat | agent_id: agent, status: "started"}
        chat = Repo.update(chat)
        {:ok, chat}
      chat.status == "started" and chat.agent_id == agent ->
        {:returned, chat}
      chat.status == "started" and chat.agent_id != agent ->
        {:started, "Chat already started"}
    end

  end

  def end_chat(id) do
    chat = Repo.get!(Chat, id)
    chat = %{chat | status: "ended"}
    Repo.update(chat)
  end
end
