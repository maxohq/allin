defmodule Allin.Repo do
  use Allin.EctoBehaviour, validate: false
  def all(q), do: all(q, [])
  def one(q), do: one(q, [])
  def one!(q), do: one!(q, [])
  def insert(q), do: insert(q, [])
  def insert!(q), do: insert!(q, [])
end
