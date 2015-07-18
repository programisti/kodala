defmodule Kodala.RethinkRepo do
  #use RethinkDB.Connection

  def start_link do
    conn = RethinkDB.connect
    Agent.start_link(fn -> conn end, name: __MODULE__)
    {:ok, self}
  end

  def run(query) do
    Agent.get(__MODULE__, fn conn ->
      RethinkDB.run conn, query
    end)
  end


  #def get_chat_history(chat_id) do
    #table("people") 
    #|> filter(%{chat_id: chat_id})
    #|> RethinkRepo.run
  #end
end
