defmodule Allin.MixProject do
  use Mix.Project
  @github_url "https://github.com/maxohq/allin"
  @version "0.1.0"
  @description "Allin description"

  def project do
    [
      app: :allin,
      source_url: @github_url,
      version: @version,
      description: @description,
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      test_paths: ["test", "lib"],
      test_pattern: "*_test.exs",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Allin.Application, []}
    ]
  end

  def elixirc_paths(:test), do: ["lib", "test/support"]
  def elixirc_paths(_), do: ["lib"]

  defp package do
    [
      files: ~w(lib mix.exs README* CHANGELOG*),
      licenses: ["MIT"],
      links: %{
        "Github" => @github_url,
        "Changelog" => "#{@github_url}/blob/main/CHANGELOG.md"
      }
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:maxo_adapt, "~> 0.1.7"},
      {:ecto, "~> 3.10"},
      {:ecto_sql, "~> 3.10"},
      {:ecto_sqlite3, "~> 0.10"},

      # DB drivers
      {:postgrex, "~> 0.17", optional: false},
      {:myxql, "~> 0.6.3", optional: false},
      {:exqlite, "~> 0.13", optional: false},

      # DEV
      {:ex_doc, "~> 0.29", only: :dev, runtime: false},
      {:maxo_test_iex, "~> 0.1", only: [:test]},
      {:mneme, "~> 0.3", only: [:test]}
    ]
  end

  defp aliases do
    [
      setup: ~w|deps.get ecto.setup|,
      "ecto.setup": ~w|app.config ecto.create ecto.migrate|,
      "ecto.reset": ~w|app.config ecto.drop ecto.setup|,
      "ecto.gen.migration": ~w|app.config ecto.gen.migration|,
      test: ["app.config", "ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
