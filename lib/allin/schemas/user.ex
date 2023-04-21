defmodule Allin.Schemas.User do
  use Ecto.Schema

  schema "users" do
    field(:name, :string)
    field(:email, :string)
    timestamps()
  end
end
