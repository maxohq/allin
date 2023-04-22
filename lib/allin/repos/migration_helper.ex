defmodule Allin.Repos.MigrationHelper do
  @types %{
    Ecto.Adapters.MyXQL => :mysql,
    Ecto.Adapters.Postgres => :psql,
    Ecto.Adapters.SQLite3 => :sqlite
  }

  def repo_type(repo) do
    adapter = repo.__adapter__()
    Map.fetch!(@types, adapter)
  end
end
