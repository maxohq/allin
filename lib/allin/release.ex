defmodule Allin.Release do
  @app :allin

  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def rollback() do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, all: true))
    end
  end

  defp repos do
    Application.get_env(:allin, :ecto_repos)
  end

  defp load_app do
    Application.load(@app)
  end
end
