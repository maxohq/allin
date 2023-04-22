# Allin

Example application how to use a single Ecto Repo that supports multiple DB engines.

Features:

- uses [MaxoAdapt](https://github.com/maxohq/maxo_adapt) for dynamic DB adapter switching + great dev experience
- seamless **runtime** switching between DB engines possible, while still using the same main Repo module
- support for database-specific migrations, when needed
- migrations for all databases are kept together, to simplify code reuse as much as possible
- same ExUnit tests can be run for different DB engines via ENV variable switch
- Mix Ecto commands work as usual

## Setup

Please start postgres / mysql with the included docker-compose file!

```bash
$ docker compose up
```

Now try the Elixir app without any options:

```bash
$ iex -S mix
** (Mix) Could not start application allin: exited in: Allin.Application.start(:normal, [])
    ** (EXIT) an exception was raised:
        ** (RuntimeError) PLEASE PROVIDE `DBTYPE` ENV variable - psql / mysql / sqlite!
            (allin 0.1.0) lib/allin/setup.ex:13: Allin.Setup.assert_correct_db_type!/0
            (allin 0.1.0) lib/allin/setup.ex:18: Allin.Setup.setup_repo!/0
            (allin 0.1.0) lib/allin/application.ex:8: Allin.Application.start/2
            (kernel 8.5.3) application_master.erl:293: :application_master.start_it_old/4

```

It fails, because we did not provide the desired DB type to be configured. Let's do it now:

With SQLITE:

```elixir
$ DBTYPE=sqlite iex -S mix
iex(1)> Allin.Repo.query("select 2 + 2")
{:ok,
 %Exqlite.Result{
   command: :execute,
   columns: ["2 + 2"],
   rows: [[4]],
   num_rows: 1
 }}
```

With MySQL:

```elixir
$ DBTYPE=mysql iex -S mix
iex(1)> Allin.Repo.query("select 2 + 2")
{:ok,
 %MyXQL.Result{
   columns: ["2 + 2"],
   connection_id: 109,
   last_insert_id: nil,
   num_rows: 1,
   rows: [[4]],
   num_warnings: 0
 }}
```

And with Postgres

```elixir
$ DBTYPE=psql iex -S mix
iex(1)> Allin.Repo.query("select 2 + 2")
{:ok,
 %Postgrex.Result{
   command: :select,
   columns: ["?column?"],
   rows: [[4]],
   num_rows: 1,
   connection_id: 779,
   messages: []
 }}
```

Enjoy! 💜

### Details

- Allin.Repos.Setup

  - single module to contain most of the logic for (re-) configuration of repos
  - `Allin.Repos.Setup.setup_repo!(true)`
    - used in mix tasks to start the rep
  - `Allin.Repos.Setup.setup_env()`

    - used in config/runtime.exs to configure the `:ecto_repos` list dynamically
    - is also ran on any live re-configuration of the repo

  - `Allin.Repos.Setup.to_mysql()`

    - runtime switching to MySQL DB

  - `Allin.Repos.Setup.to_psql()`

    - runtime switching to Postgres DB

  - `Allin.Repos.Setup.to_sqlite()`
    - runtime switching to Sqlite DB

- Allin.Repos.RepoSupervisor

  - dynamic supervisor for repositories
  - allows clean switching between different DB-specific adapter repos
  - starting and stopping them accordingly

- mix app.config (used in mix.exs / aliases)

  - needed to make config/runtime.exs work with Repo config for Mix tasks
  - https://elixirforum.com/t/config-runtime-exs-not-loaded-on-mix-tasks/38034
