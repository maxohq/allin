defmodule Allin.Repos.Setup do
  @valid_db_types ["mysql", "psql", "sqlite"]
  @main_repo Allin.Repo

  def setup_repo!(boot \\ true) do
    assert_correct_db_type!()
    if dbtype?("mysql"), do: to_mysql(boot)
    if dbtype?("psql"), do: to_psql(boot)
    if dbtype?("sqlite"), do: to_sqlite(boot)
  end

  def assert_correct_db_type! do
    if dbtype() not in @valid_db_types do
      raise "PLEASE PROVIDE `DBTYPE` ENV variable - psql / mysql / sqlite!"
    end
  end

  def repo_module(), do: repo_module(dbtype())
  def repo_module("mysql"), do: Allin.RepoMysql
  def repo_module("psql"), do: Allin.RepoPsql
  def repo_module("sqlite"), do: Allin.RepoSqlite

  def dbtype, do: System.get_env("DBTYPE")
  def dbtype?(type), do: dbtype() == type

  def to_mysql(boot \\ true), do: ensure_repo_started(:myxql, Allin.RepoMysql, boot)
  def to_psql(boot \\ true), do: ensure_repo_started(:postgrex, Allin.RepoPsql, boot)
  def to_sqlite(boot \\ true), do: ensure_repo_started(:exqlite, Allin.RepoSqlite, boot)

  def setup_env(repo \\ nil) do
    repo = if repo, do: repo, else: repo_module()
    Application.put_env(:allin, :ecto_repos, [repo])
  end

  defp ensure_repo_started(db_app, repo_mod, start_repo) do
    ensure_current_stopped()
    setup_env(repo_mod)
    :application.ensure_all_started(:ecto_sql)
    :application.ensure_all_started(db_app)
    if start_repo, do: Allin.Repos.RepoSupervisor.start_child(repo_mod)
    @main_repo.configure(repo_mod)
  end

  def start_dynamic(repo_mod, opts) do
    ensure_current_stopped()
    setup_env(repo_mod)
    Allin.Repos.RepoSupervisor.start_child(repo_mod, opts)
    @main_repo.configure(repo_mod)
  end

  def ensure_current_stopped do
    if mod = @main_repo.maxo_adapt() do
      Allin.Repos.RepoSupervisor.stop_child(mod)
    end
  end
end
