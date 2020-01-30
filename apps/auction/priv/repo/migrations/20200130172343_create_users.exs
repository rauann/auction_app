defmodule Auction.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table("users") do
      add(:username, :string)
      add(:email_address, :string)
      add(:hashed_password, :string)
      timestamps()
    end

    # adding database constraint to ensure the username is uniq
    create(unique_index(:users, [:username]))
  end
end
