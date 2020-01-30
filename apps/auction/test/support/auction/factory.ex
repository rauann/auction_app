defmodule Auction.Factory do
  use ExMachina.Ecto, repo: Auction.Repo

  def item_factory do
    %Auction.Item{
      title: sequence(:title, &"Item #{&1}"),
      description: "Something",
      ends_at: ~U[2200-01-01 00:00:00Z]
    }
  end

  def user_factory do
    %Auction.User{
      username: sequence(:username, &"Ibra#{&1}"),
      email_address: sequence(:email_address, &"ibra#{&1}@bol.com")
    }
  end
end
