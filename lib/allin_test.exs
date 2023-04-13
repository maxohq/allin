defmodule AllinTest do
  use ExUnit.Case
  use MnemeDefaults

  test "greeting" do
    auto_assert("Welcome to Maxo!" <- Allin.greeting())
  end
end
