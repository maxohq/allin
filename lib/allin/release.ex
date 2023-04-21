defmodule Allin.Release do
  @app :allin

  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  defp repos do
    [MaxoAdapt.Allin.Repo.__maxo_adapt__()]
  end

  defp load_app do
    Application.load(@app)
  end
end
