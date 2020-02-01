defmodule AuctionWeb.BidController do
  use AuctionWeb, :controller
  import AuctionWeb.Endpoint
  plug :require_logged_in_user

  def create(conn, %{"bid" => %{"amount" => amount}, "item_id" => item_id}) do
    user_id = conn.assigns.current_user.id

    case Auction.insert_bid(%{amount: amount, item_id: item_id, user_id: user_id}) do
      {:ok, bid} ->
        html_body =
          Phoenix.View.render_to_string(AuctionWeb.BidView, "bid.html",
            bid: bid,
            username: conn.assigns.current_user.username
          )

        broadcast("item:#{item_id}", "new_bid", %{body: html_body})
        redirect(conn, to: Routes.item_path(conn, :show, bid.item_id))

      {:error, changeset} ->
        item = Auction.get_item_with_bids(item_id)

        conn
        |> put_view(AuctionWeb.ItemView)
        |> render(:show, item: item, bid: changeset)
    end
  end

  defp require_logged_in_user(%{assigns: %{current_user: nil}} = conn, _opts) do
    conn
    |> put_flash(:error, "You must be logged in to bid")
    |> redirect(to: Routes.item_path(conn, :index))
    |> halt()
  end

  defp require_logged_in_user(conn, _opts), do: conn
end
