defmodule Kodala.Session do
  alias Kodala.User
  alias Kodala.Repo
  require Logger

  def login(params) do
    user = Repo.get_by(User, email: String.downcase(params["email"]))
    password = params["password"]
    qwe  = authenticate(user, params["password"]) 
    asd = Comeonin.Bcrypt.checkpw(password, user.encrypted_password)
    Logger.error "> checkpwd: #{inspect asd} password: #{inspect password}"
    case qwe do
      true -> {:ok, user}
      _    -> :error
    end
  end

  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :current_user)
    if id, do: Repo.get(User, id)
  end

  def logged_in?(conn), do: !!current_user(conn)

  defp authenticate(user, password) do
    case user do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, user.encrypted_password)
    end
  end
end
