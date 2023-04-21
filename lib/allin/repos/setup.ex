defmodule Allin.Repos.Setup do
  @valid_db_types ["mysql", "psql", "sqlite"]

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

  def to_mysql(boot \\ true), do: setup_repo(:myxql, Allin.RepoMysql, boot)
  def to_psql(boot \\ true), do: setup_repo(:postgrex, Allin.RepoPsql, boot)
  def to_sqlite(boot \\ true), do: setup_repo(:exqlite, Allin.RepoSqlite, boot)

  def setup_env(repo \\ nil) do
    repo = if repo, do: repo, else: repo_module()
    Application.put_env(:allin, :ecto_repos, [repo])
  end

  defp setup_repo(db_app, repo_mod, start_repo) do
    ensure_current_stopped()
    setup_env(repo_mod)
    :application.ensure_all_started(:ecto_sql)
    :application.ensure_all_started(db_app)
    if start_repo, do: Allin.Repos.RepoSupervisor.start_child(repo_mod)
    Allin.Repo.configure(repo_mod)
  end

  def ensure_current_stopped do
    if module_exists?(MaxoAdapt.Allin.Repo) do
      if mod = Allin.Repo.adapter() do
        Allin.Repos.RepoSupervisor.stop_child(mod)
      end
    end
  end

  def module_exists?(mod) do
    function_exported?(mod, :__info__, 1)
  end
end
