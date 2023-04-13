import Config

config :logger, level: :debug

config :allin, Allin.RepoPsql,
  username: "postgres",
  password: "postgres",
  hostname: "127.0.0.1",
  database: "maxo_sql",
  port: 5551

config :allin, Allin.RepoMysql,
  database: "maxo_sql",
  username: "root",
  password: "mysql",
  hostname: "127.0.0.1",
  port: 5552

config :allin, Allin.RepoSqlite, database: "./data/allin_dev.db"

config :allin,
  ecto_repos: [Allin.RepoSqlite, Allin.RepoMysql, Allin.RepoPsql]
