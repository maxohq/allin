defmodule Allin.Repos.Setup do
  @valid_db_types ["mysql", "psql", "sqlite"]

  def setup_repo! do
    assert_correct_db_type!()
    if dbtype?("mysql"), do: to_mysql(false)
    if dbtype?("psql"), do: to_psql(false)
    if dbtype?("sqlite"), do: to_sqlite(false)
  end

  def assert_correct_db_type! do
    if dbtype() not in @valid_db_types do
      raise "PLEASE PROVIDE `DBTYPE` ENV variable - psql / mysql / sqlite!"
    end
  end

  def dbtype, do: System.get_env("DBTYPE")
  def dbtype?(type), do: dbtype() == type

  def to_mysql(boot \\ true), do: setup_repo(:myxql, Allin.RepoMysql, boot)
  def to_psql(boot \\ true), do: setup_repo(:postgrex, Allin.RepoPsql, boot)
  def to_sqlite(boot \\ true), do: setup_repo(:exqlite, Allin.RepoSqlite, boot)

  defp setup_repo(db_app, repo_mod, start_repo) do
    :application.ensure_all_started(db_app)
    if start_repo, do: repo_mod.start_link()
    Allin.Repo.configure(repo_mod)
  end
end
