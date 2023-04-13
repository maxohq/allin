# Allin

Example how to use multiple DB engines with a single Repo and [MaxoAdapt](https://github.com/maxohq/maxo_adapt).

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

Start with the [lib/allin/application.ex](https://github.com/maxohq/allin/blob/main/lib/allin/application.ex) file to figure out the internal workings. It's not a lot of code :)
