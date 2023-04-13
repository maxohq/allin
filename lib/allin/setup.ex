defmodule Allin.Setup do
  def dbtype do
    System.get_env("DBTYPE")
  end

  def dbtype?(type) do
    dbtype() == type
  end

  @valid_db_types ["mysql", "psql", "sqlite"]
  def assert_correct_db_type! do
    if dbtype() not in @valid_db_types do
      raise "PLEASE PROVIDE `DBTYPE` ENV variable - psql / mysql / sqlite!"
    end
  end

  def setup_repo! do
    assert_correct_db_type!()

    if dbtype?("mysql") do
      Allin.Repo.configure(Allin.RepoMysql)
    end

    if dbtype?("psql") do
      Allin.Repo.configure(Allin.RepoPsql)
    end

    if dbtype?("sqlite") do
      Allin.Repo.configure(Allin.RepoSqlite)
    end
  end

  # def to_mysql do
  #   :application.ensure_all_started(:myxql)
  #   Allin.RepoMysql.start_link()
  #   Allin.Repo.configure(Allin.RepoMysql)
  # end

  # def to_psql do
  #   :application.ensure_all_started(:postgrex)
  #   Allin.RepoPsql.start_link()
  #   Allin.Repo.configure(Allin.RepoPsql)
  # end

  # def to_sqlite do
  #   :application.ensure_all_started(:exqlite)
  #   Allin.RepoSqlite.start_link()
  #   Allin.Repo.configure(Allin.RepoSqlite)
  # end
end
