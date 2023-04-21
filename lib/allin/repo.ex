defmodule Allin.Repo do
  use Allin.EctoBehaviour, validate: false

  def adapter do
    if module_exists?(MaxoAdapt.Allin.Repo) do
      # `MaxoAdapt.Allin.Repo` does not exist for dialyzer
      Module.concat([MaxoAdapt, Allin.Repo]).__maxo_adapt__()
    end
  end

  defp module_exists?(mod) do
    function_exported?(mod, :__info__, 1)
  end
end
