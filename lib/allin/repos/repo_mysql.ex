defmodule Allin.RepoMysql do
  use Ecto.Repo,
    otp_app: :allin,
    adapter: Ecto.Adapters.MyXQL,
    priv: "priv/repo"

  @impl true
  def init(_context, config), do: {:ok, config}
end
