defmodule Allin.Application do
  @moduledoc false
  use Application
  alias Allin.Repos.Setup

  @impl true
  def start(_type, _args) do
    children = [
      Allin.Repos.RepoSupervisor
    ]

    opts = [strategy: :one_for_one, name: Allin.Supervisor]
    res = Supervisor.start_link(children, opts)
    # Add the initial repo to our RepoSupervisor
    Setup.setup_repo!(true)
    res
  end
end
