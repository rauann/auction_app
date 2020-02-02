use Mix.Config

config :auction, Auction.Repo,
  database: "auction_#{Mix.env()}",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  port: "5432",
  pool: Ecto.Adapters.SQL.Sandbox

config :logger, level: :info
