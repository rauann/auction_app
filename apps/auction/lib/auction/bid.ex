defmodule Auction.Bid do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bids" do
    field(:amount, :integer)
    belongs_to(:item, Auction.Item)
    belongs_to(:user, Auction.User)

    timestamps()
  end

  def changeset(bid, params \\ %{}) do
    bid
    |> cast(params, [:amount, :item_id, :user_id])
    |> validate_required([:amount, :item_id, :user_id])
    |> assoc_constraint(:item)
    |> assoc_constraint(:user)
  end
end
