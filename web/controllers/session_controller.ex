defmodule Kodala.SessionController do
  use Kodala.Web, :controller
  require Logger

  plug :scrub_params, "session" when action in [:create]

  def new(conn, _params) do
    render conn, "new.html"
  end
	
	def create(conn, %{"session" => session_params}) do
    case Kodala.Session.login(session_params) do
      {:ok, user} ->
        Logger.debug "> Session.login succeed :)"
        conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "Logged in")
        |> redirect(to: "/")
      :error ->
        conn
        |> put_flash(:info, "Wrong email or password")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "Logged out")
    |> redirect(to: "/")
  end

end
