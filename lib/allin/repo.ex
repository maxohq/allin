defmodule Allin.Repo do
  # use Ecto.Repo,
  #   otp_app: :allin,
  #   adapter: Ecto.Adapters.SQLite3

  use MaxoAdapt

  behaviour do
    @doc ~S"""
    Query DB with plain SQL
    """
    @callback query(sql :: binary) :: {:ok, any() | nil} | {:error, atom}
  end
end
