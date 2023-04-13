defmodule Allin.RepoMysql do
  use Ecto.Repo,
    otp_app: :allin,
    adapter: Ecto.Adapters.MyXQL
end
