defmodule Allin.Repo do
  use MaxoAdapt

  behaviour do
    @doc ~S"""
    Get session from storage.
    """
    @callback query(sql :: binary) :: {:ok, any() | nil} | {:error, atom}
  end
end
