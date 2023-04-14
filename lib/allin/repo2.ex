defmodule Allin.Repo2 do
  use MaxoAdapt, mode: :get_compiled

  behaviour do
    @doc ~S"""
    Query DB with plain SQL
    """
    @callback query(sql :: binary) :: {:ok, any() | nil} | {:error, atom}
  end
end
