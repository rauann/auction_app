defmodule AuctionWeb.UserController do
  use AuctionWeb, :controller
  # implementing a plug as a function
  plug :prevent_unauthorized_access when action in [:show]

  def new(conn, _params) do
    user = Auction.new_user()
    render(conn, "new.html", user: user)
  end

  def show(conn, %{"id" => id}) do
    user = Auction.get_user(id)
    bids = Auction.get_bids_for_user(user)
    render(conn, :show, user: user, bids: bids)
  end

  def create(conn, %{"user" => attrs}) do
    case Auction.insert_user(attrs) do
      {:ok, user} -> redirect(conn, to: Routes.user_path(conn, :show, user))
      {:error, changeset} -> render(conn, "new.html", user: changeset)
    end
  end

  defp prevent_unauthorized_access(conn, _opts) do
    current_user = Map.get(conn.assigns, :current_user)

    request_user_id =
      conn.params
      |> Map.get("id")
      |> String.to_integer()

    if current_user == nil || current_user.id != request_user_id do
      conn
      |> put_flash(:error, "Nice try")
      |> redirect(to: Routes.item_path(conn, :index))
      # tells the plug to stop processing the request
      |> halt()
    else
      conn
    end
  end
end
