defmodule AuctionWeb.ItemControllerTest do
  use AuctionWeb.ConnCase

  import Auction.Factory

  setup do
    Auction.Repo.delete_all(Auction.Item)
    :ok
  end

  test "GET /items/:id", %{conn: conn} do
    item = insert(:item)
    conn = get(conn, "/items/#{item.id}")
    assert html_response(conn, 200) =~ "#{item.title}"
  end
end
