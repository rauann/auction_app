defmodule AuctionWeb.ItemController do
  use AuctionWeb, :controller

  def index(conn, _params) do
    items = Auction.list_items()
    render(conn, "index.html", items: items)
  end

  def show(conn, %{"id" => id}) do
    item = Auction.get_item(id)
    render(conn, "show.html", item: item)
  end

  def new(conn, _params) do
    item = Auction.new_item()
    render(conn, "new.html", item: item)
  end

  def create(conn, %{"item" => attrs}) do
    case Auction.insert_item(attrs) do
      {:ok, item} -> redirect(conn, to: Routes.item_path(conn, :show, item))
      {:error, changeset} -> render(conn, "new.html", item: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    item = Auction.edit_item(id)
    render(conn, "edit.html", item: item)
  end

  def update(conn, %{"id" => id, "item" => attrs}) do
    item = Auction.get_item(id)

    case Auction.update_item(item, attrs) do
      {:ok, item} -> redirect(conn, to: Routes.item_path(conn, :show, item))
      {:error, changeset} -> render(conn, "edit.html", item: changeset)
    end
  end
end
