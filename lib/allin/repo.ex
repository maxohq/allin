defmodule Allin.Repo do
  use MaxoAdapt

  behaviour do
    @doc ~S"""
    Get session from storage.
    """
    @callback query(sql :: binary) :: {:ok, any() | nil} | {:error, atom}
  end

  def to_mysql do
    Allin.Repo.configure(Allin.RepoMysql)
  end

  def to_psql do
    Allin.Repo.configure(Allin.RepoPsql)
  end

  def to_sqlite do
    Allin.Repo.configure(Allin.RepoSqlite)
  end
end
