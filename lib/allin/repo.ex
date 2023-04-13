defmodule Allin.Repo do
  use MaxoAdapt

  behaviour do
    @doc ~S"""
    Query DB with plain SQL
    """
    @callback query(sql :: binary) :: {:ok, any() | nil} | {:error, atom}
  end
end
