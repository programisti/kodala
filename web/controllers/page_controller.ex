defmodule Kodala.PageController do
  use Kodala.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
