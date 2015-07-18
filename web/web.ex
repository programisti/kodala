defmodule Kodala.Web do

  def model do
    quote do
      use Ecto.Model
    end
  end

  def controller do
    quote do
      use Phoenix.Controller

      # Import User model
      alias Kodala.User

      # Alias the data repository and import query/model functions
      alias Kodala.Repo
      import Ecto.Model
      import Ecto.Query, only: [from: 2]

      # Import URL helpers from the router
      import Kodala.Router.Helpers
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "web/templates"

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      # Import URL helpers from the router
      import Kodala.Router.Helpers

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      # Session Helpers
      import Kodala.Session, only: [current_user: 1, logged_in?: 1]
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      # Alias the data repository and import query/model functions
      alias Kodala.Repo
      import Ecto.Model
      import Ecto.Query, only: [from: 2]

    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
