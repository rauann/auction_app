defmodule AuctionWeb.ItemControllerTest do
  use AuctionWeb.ConnCase

  import Auction.Factory

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Auction.Repo)
  end

  test "GET /items/:id", %{conn: conn} do
    item = insert(:item)
    conn = get(conn, "/items/#{item.id}")
    assert html_response(conn, 200) =~ "#{item.title}"
  end

  describe "POST /items" do
    test "with valid params, create new item", %{conn: conn} do
      count = Enum.count(Auction.list_items())
      post conn, "/items", %{"item" => %{"title" => "Item 1"}}
      assert Enum.count(Auction.list_items()) == count + 1
    end

    test "with valid params, redirects to the new Item", %{conn: conn} do
      conn = post(conn, "/items", %{"item" => %{"title" => "Item 1"}})
      assert redirected_to(conn) =~ ~r(/items/\d+)
    end

    test "with invalid params, does not create new item", %{conn: conn} do
      count = Enum.count(Auction.list_items())
      post conn, "/items", %{"item" => %{"title" => ""}}
      assert Enum.count(Auction.list_items()) == count
    end
  end
end
