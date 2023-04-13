defmodule Allin.RepoPsql do
  use Ecto.Repo,
    otp_app: :allin,
    adapter: Ecto.Adapters.Postgres
end
