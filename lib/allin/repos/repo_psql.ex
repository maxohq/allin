defmodule Allin.RepoPsql do
  use Ecto.Repo,
    otp_app: :allin,
    adapter: Ecto.Adapters.Postgres

  @impl true
  def init(_context, config), do: {:ok, config}
end
