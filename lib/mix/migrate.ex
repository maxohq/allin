defmodule Mix.Tasks.Migrate.Up do
  @shortdoc "Runs custom migrations - up"
  @moduledoc """
  """

  use Mix.Task

  @doc false
  def run(_args) do
    Allin.Repos.Setup.setup_repo!(true)
    Allin.Release.migrate()
  end
end

defmodule Mix.Tasks.Migrate.Down do
  @shortdoc "Runs custom migrations - down"
  @moduledoc """
  """

  use Mix.Task

  @doc false
  def run(_args) do
    Allin.Repos.Setup.setup_repo!(true)
    Allin.Release.rollback()
  end
end
