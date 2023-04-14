defmodule Check do
  alias Allin.Schemas.User
  alias Allin.RepoSqlite

  def run do
    require Ecto.Query
    import Ecto.Query
    q = from(User)
    q |> IO.inspect(structs: false)
    RepoSqlite.all(q)
    # Ecto.Adapters.SQLite3.Connection.all(q)
  end
end
