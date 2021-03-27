defmodule Hui.Repo do
  use Ecto.Repo,
    otp_app: :hui,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
end
