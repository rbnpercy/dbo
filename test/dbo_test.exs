defmodule DboTest do
  use ExUnit.Case #, async: true

  ##
  # CONNECTION TESTS
  ##
  test "connection requires db, user & pass" do
    assert {:ok, pid} = Dbo.DB.connect("testy", "luno", "Devtits1234")
  end

  test "can disconnect from database" do
    {:ok, db} = Dbo.DB.connect("testy", "luno", "Devtits1234")
    assert Dbo.DB.disconnect(db) == :ok
  end






end
