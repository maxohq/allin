defmodule Allin.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table("users") do
      add :name,  :string, size: 40
      add :email, :string

      timestamps()
    end
  end
end
