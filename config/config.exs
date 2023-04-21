import Config

config :logger, level: :debug

config :allin, Allin.RepoPsql,
  username: "postgres",
  password: "postgres",
  hostname: "127.0.0.1",
  database: "maxo_sql",
  port: 5551,
  priv: "priv/repo"

config :allin, Allin.RepoMysql,
  database: "maxo_sql",
  username: "root",
  password: "mysql",
  hostname: "127.0.0.1",
  port: 5552,
  priv: "priv/repo"

config :allin, Allin.RepoSqlite, database: "./data/allin_dev.db", priv: "priv/repo"
config :allin, Allin.Repo, database: "./data/allin_dev.db", priv: "priv/repo"

config :allin,
  # ecto_repos: [Allin.RepoSqlite, Allin.RepoMysql, Allin.RepoPsql]
  ecto_repos: [Allin.RepoSqlite]

# config :allin,
#   ecto_repos: [Allin.Repo]

# config :maxo_adapt, allin_repo2: Allin.RepoPsql

config :maxo_adapt, allin_repo2: Allin.RepoPsql
