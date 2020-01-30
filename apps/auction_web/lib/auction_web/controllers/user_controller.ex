defmodule AuctionWeb.UserController do
  use AuctionWeb, :controller

  def new(conn, _params) do
    user = Auction.new_user()
    render(conn, "new.html", user: user)
  end

  def show(conn, %{"id" => id}) do
    user = Auction.get_user(id)
    render(conn, "show.html", user: user)
  end

  def create(conn, %{"user" => attrs}) do
    case Auction.insert_user(attrs) do
      {:ok, user} -> redirect(conn, to: Routes.user_path(conn, :show, user))
      {:error, changeset} -> render(conn, "new.html", user: changeset)
    end
  end
end
