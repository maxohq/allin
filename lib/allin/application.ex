defmodule Allin.Application do
  @moduledoc false
  use Application
  alias Allin.Repos.Setup

  @impl true
  def start(_type, _args) do
    Setup.setup_repo!()

    children =
      maybe_start_repo("psql", Allin.RepoPsql) ++
        maybe_start_repo("mysql", Allin.RepoMysql) ++
        maybe_start_repo("sqlite", Allin.RepoSqlite)

    opts = [strategy: :one_for_one, name: Allin.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def maybe_start_repo(dbtype, repo) do
    if Setup.dbtype?(dbtype), do: [repo], else: []
  end
end
