defmodule Allin.RepoMysql do
  use Ecto.Repo,
    otp_app: :allin,
    adapter: Ecto.Adapters.MyXQL

  @impl true
  def init(_context, config), do: {:ok, config}
end
