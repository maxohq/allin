defmodule Check do
  alias Allin.Repos.Setup
  alias Allin.Schemas.User
  alias Allin.Repo
  require Ecto.Query

  def run_mysql do
    Setup.to_mysql()
    Repo.query("truncate users")
    insert_records(100, "mysql")
  end

  def run_psql do
    Setup.to_psql()
    Repo.query("truncate users restart identity")
    insert_records(100, "psql")
  end

  def run_sqlite do
    Setup.to_sqlite()
    Repo.query("delete from users")
    Repo.query("UPDATE SQLITE_SEQUENCE SET seq = 0 WHERE name = 'users'")
    insert_records(100, "sqlite")
  end

  def insert_records(amount, prefix) do
    defaults = %{
      inserted_at: now(),
      updated_at: now()
    }

    rows =
      for i <- 1..amount do
        Map.merge(defaults, %{name: "#{prefix}-#{i}"})
      end

    Repo.insert_all(User, rows, [])
  end

  def now(), do: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
end
