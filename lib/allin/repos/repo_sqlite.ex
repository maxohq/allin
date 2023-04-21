defmodule Allin.RepoSqlite do
  use Ecto.Repo,
    otp_app: :allin,
    adapter: Ecto.Adapters.SQLite3,
    priv: "priv/repo"

  @impl true
  def init(_context, config), do: {:ok, config}
end
