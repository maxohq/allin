import Config

config :maxo_adapt, debug: false

## dynamic repo config based on ENV variables
Allin.Repos.Setup.assert_correct_db_type!()
Allin.Repos.Setup.setup_env()
