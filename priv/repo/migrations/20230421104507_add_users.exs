defmodule Allin.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    type = Allin.Repos.MigrationHelper.repo_type(repo())
    change(type)
  end

  def change(:sqlite) do
    create table("users") do
      add :name,  :string, size: 40
      add :email, :string
      add :extra_sqlite, :string

      timestamps()
    end
  end

  def change(:psql) do
    create table("users") do
      add :name,  :string, size: 40
      add :email, :string
      add :extra_psql, :string

      timestamps()
    end
  end

  def change(:mysql) do
    create table("users") do
      add :name,  :string, size: 40
      add :email, :string
      add :extra_mysql, :string

      timestamps()
    end
  end
end
