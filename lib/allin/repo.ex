defmodule Allin.Repo do
  use Allin.EctoBehaviour, validate: false

  def adapter do
    # `MaxoAdapt.Allin.Repo` does not exist for dialyzer
    Module.concat([MaxoAdapt, Allin.Repo]).__maxo_adapt__()
  end
end
