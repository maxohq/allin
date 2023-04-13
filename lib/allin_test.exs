defmodule AllinTest do
  use ExUnit.Case
  use MnemeDefaults

  test "greeting" do
    auto_assert(Allin.greeting())
  end
end
