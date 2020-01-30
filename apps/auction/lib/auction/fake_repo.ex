defmodule Auction.FakeRepo do
  alias Auction.Item

  @items [
    %Item{
      id: 1,
      title: "Item 1",
      description: "A tasty item sure to please",
      ends_at: DateTime.utc_now()
    },
    %Item{
      id: 2,
      title: "Item 2",
      description: "A tasty item sure to please",
      ends_at: DateTime.utc_now()
    },
    %Item{
      id: 3,
      title: "Item 3",
      description: "A tasty item sure to please",
      ends_at: DateTime.utc_now()
    }
  ]

  def all(Item) do
    @items
  end

  def get!(Item, id) do
    @items
    |> Enum.find(&(&1.id === id))
  end

  def get_by(Item, attrs) do
    Enum.find(@items, fn item ->
      Enum.all?(Map.keys(attrs), fn key ->
        Map.get(item, key) === attrs[key]
      end)
    end)
  end
end
