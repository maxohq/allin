defmodule Allin.Schemas.User do
  use Ecto.Schema

  schema "users" do
    field(:city, :string)
    field(:temp_lo, :integer)
    field(:temp_hi, :integer)
    field(:prcp, :float)
    timestamps()
  end
end
