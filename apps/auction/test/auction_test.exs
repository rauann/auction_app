defmodule AuctionTest do
  use ExUnit.Case

  alias Auction.{Repo, Item}

  import Auction.Factory
  import Ecto.Query, only: [from: 2]

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

  describe "insert_item/1" do
    setup do
      item_params = params_for(:item)
      {:ok, item_params: item_params}
    end

    # ways to test db persistence
    test "insert_item/1", %{item_params: %{title: title} = item_params} do
      assert {:ok, _} = Auction.insert_item(item_params)
      assert %{title: ^title} = Auction.get_item_by(title: title)
    end

    test "insert_item/1 (test count)", %{item_params: item_params} do
      count_query = from(i in Item, select: count(i.id))
      assert Repo.one(count_query) == 0
      Auction.insert_item(item_params)
      assert Repo.one(count_query) == 1
    end
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
