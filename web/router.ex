defmodule Kodala.Router do
  use Kodala.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    #plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  socket "/ws", Kodala do
    channel "rooms:*", RoomChannel
    channel "chat:*", ChatChannel
  end

  scope "/", Kodala do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/desk", DeskController, :index
    get "/chat/:id", ChatController, :show
    get "/chat/error", ChatController, :error

    get "/register", RegistrationController, :new
    post "/register", RegistrationController, :create

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
  end


  # Other scopes may use custom stacks.
  # scope "/api", Kodala do
  #   pipe_through :api
  # end
end
