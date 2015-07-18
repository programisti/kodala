defmodule Kodala.RoomChannel do
  use Phoenix.Channel
  require Logger
  alias Kodala.Chat
  alias Exrethinkdb.Query
  alias Kodala.RethinkRepo

  def join("rooms:" <> room, msg, socket) do
    Process.flag(:trap_exit, true)

    case msg do
      %{"type" => "client", "name" => client, "ip" => ip} -> 
        chat = Chat.create(client, room, ip)
        auth = %{type: "client", name: client, chat: chat}
        socket = assign(socket, :auth, auth)
        send(self, {:client_joined, chat})
      %{"type" => "agent", "name" => agent} -> 
        auth = %{type: "agent", name: agent, room: room}
        socket = assign(socket, :auth, auth)
        send(self, {:agent_joined, auth})
      %{type: "system", name: "system", chat: chat} ->
        socket = assign(socket, :auth, msg)
      _ -> 
        auth = %{ type: "anon", name: "anon"}
        socket = assign(socket, :auth, auth)
    end
    {:ok, socket}
  end

  def terminate(reason, socket) do
    case socket.assigns.auth do
      %{type: "client", name: client, chat: chat} ->
        Logger.error "> terminate chat.id: #{inspect chat.id}"
        send(self, {:client_leaved, chat})
      %{type: "agent", name: agent, room: room} ->
        send(self, {:agent_leaved, socket.assigns})
      _ -> Logger.error "> anonymous leaved"
    end
    :ok
  end

  def handle_info({:client_joined, msg}, socket) do
    broadcast! socket, "user_entered", msg 
    push socket, "chat_created", msg 
    {:noreply, socket}
  end

  def handle_info({:client_leaved, chat}, socket) do
    Logger.error "> handle_info client leaved"
    broadcast! socket, "chat_ended", chat 
    {:noreply, socket}
  end

  def handle_out("chat_ended", chat, socket) do
    Logger.error "> handle_out chat_ended msg: #{inspect chat}"
    Chat.end_chat chat.id
    push socket, "chat_ended", chat 
    {:noreply, socket}
  end

  def handle_info({:agent_joined, msg}, socket) do
    broadcast! socket, "agent_entered", msg 
    {:noreply, socket}
  end

  def handle_info({:agent_leaved, msg}, socket) do
    {:noreply, socket}
  end

  def handle_out("chat_taken", chat_id, socket) do
    push socket, "chat_taken", chat_id 
    {:noreply, socket}
  end

  def handle_out("agent_entered", chat_id, socket) do
    push socket, "agent_entered", chat_id 
    {:noreply, socket}
  end

  def handle_out("user_entered", msg, socket) do
    push socket, "user_entered", msg 
    {:noreply, socket}
  end
  
end
