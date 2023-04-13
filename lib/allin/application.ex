defmodule Allin.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Allin.RepoPsql,
      Allin.RepoMysql,
      Allin.RepoSqlite
    ]

    opts = [strategy: :one_for_one, name: Allin.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
