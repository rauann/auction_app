defmodule AuctionTest do
  use ExUnit.Case

  alias Auction.Repo

  import Auction.Factory

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "list_items/0" do
    items = insert_list(1, :item)
    assert Auction.list_items() == items
  end

  test "get_item/1" do
    item = insert(:item)
    assert Auction.get_item(item.id) == item
  end

  test "get_item_by/1" do
    item = insert(:item)
    title = item.title
    description = item.description
    assert Auction.get_item_by(title: title, description: description) == item
  end

  test "insert_item/1" do
    item = params_for(:item)
    assert {:ok, _} = Auction.insert_item(item)

    title = item.title
    assert %{title: ^title} = Auction.get_item_by(title: item.title)
  end

  test "delete_item/1" do
    item = insert(:item)
    assert {:ok, _} = Auction.delete_item(item)
  end

  describe "update_item/2" do
    test "with valid title" do
      item = insert(:item, %{title: "Foo Title"})
      assert {:ok, _} = Auction.update_item(item, %{title: "Bar Title"})
    end

    test "with invalid title" do
      item = insert(:item, %{title: "Foo Title"})
      assert {:error, _} = Auction.update_item(item, %{title: ""})
    end
  end
end
