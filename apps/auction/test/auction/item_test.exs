defmodule Auction.ItemTest do
  use ExUnit.Case
  import Auction.{Factory, ItemCase}

  alias Auction.Item

  test "ends_at cannot be in the past" do
    params = params_for(:item, %{ends_at: ~U[2019-01-01 00:00:00Z]})
    changeset = Item.changeset(%Item{}, params)
    refute changeset.valid?
    assert "ends_at cannot be in the past" in errors_on(changeset, :ends_at)
  end
end
