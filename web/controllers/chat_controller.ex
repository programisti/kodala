defmodule Kodala.ChatController do
  use Kodala.Web, :controller
  require Logger
  alias Kodala.Chat

  def show(conn, %{"id" => id}) do
    chat = Repo.get! Chat, id

    if chat.status == "started" do
      conn
      |> put_flash(:error, "chat already started")
      |> render "show.html"
    end

    render conn, "show.html", chat: chat 
  end
end
