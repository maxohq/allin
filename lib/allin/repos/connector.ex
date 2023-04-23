defmodule Allin.Repos.Connector do
  @moduledoc """
  Runtime dynamic connector based on URL

  Examples:
    iex> Allin.Repos.Connector.connect("file:./check.db?mode=memory&cache=shared")
    iex> Allin.Repos.Connector.connect("postgres://postgres:postgres@localhost:5432/av_dev")
    iex> Allin.Repos.Connector.connect("mysql://root:mysql@localhost:5552/maxo_sql")

  Test:
    iex> Allin.Repo.query("select count(*) from users")
    iex> Allin.Repo.query("select * from users limit 1")

  """
  def connect(url) do
    {repo, opts} =
      cond do
        String.starts_with?(url, "postgres:") -> {Allin.RepoPsql, normal_params(url)}
        String.starts_with?(url, "mysql:") -> {Allin.RepoMysql, normal_params(url)}
        String.starts_with?(url, "file:") -> {Allin.RepoSqlite, sqlite_params(url)}
      end

    Allin.Repos.Setup.start_dynamic(repo, opts)
  end

  defp normal_params(url) do
    [
      url: url,
      priv: "priv/repo"
    ]
  end

  defp sqlite_params(url) do
    [
      database: url,
      priv: "priv/repo"
    ]
  end
end
