defmodule Allin.RepoPsql.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    IO.puts "PSQL"
    create table("users") do
      add :city,    :string, size: 40
      add :temp_lo, :integer
      add :temp_hi, :integer
      add :prcp,    :float

      timestamps()
    end
  end
end
