defmodule Kodala.DeskController do
  use Kodala.Web, :controller
  alias Kodala.Chat

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
