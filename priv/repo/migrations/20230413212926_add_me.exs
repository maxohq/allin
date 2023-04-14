defmodule Allin.Repo.Migrations.AddMe do
  use Ecto.Migration

  def change do
    IO.puts "MAIN REPO"
    create table("users--me") do
      add :city,    :string, size: 40
      add :temp_lo, :integer
      add :temp_hi, :integer
      add :prcp,    :float

      timestamps()
    end
  end
end
