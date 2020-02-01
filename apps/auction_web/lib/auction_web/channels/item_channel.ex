defmodule AuctionWeb.ItemChannel do
  use Phoenix.Channel

  def join("item:" <> _item_id, _payload, socket) do
    {:ok, socket}
  end

  # handle incoming events from client and broadcasting it to all
  # subscribers of the socket topic. Js e.g.: channel.push("new_bid", {"foo": "bar"})
  def handle_in("new_bid", params, socket) do
    broadcast!(socket, "new_bid", params)
    {:noreply, socket}
  end
end
