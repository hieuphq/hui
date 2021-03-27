# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Hui.Repo.insert!(%Hui.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Hui.Repo
alias Hui.Schema.Currency

Repo.insert!(%Currency{
  code: "vnd",
  name: "Vietnamese Dong",
  symbol: "đ"
})

Repo.insert!(%Currency{
  code: "usd",
  name: "United States Dollar",
  symbol: "$"
})

Repo.insert!(%Currency{
  code: "gbp",
  name: "British Pounch",
  symbol: "£"
})
