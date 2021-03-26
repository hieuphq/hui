defmodule Hui.Repo do
  use Ecto.Repo,
    otp_app: :hui,
    adapter: Ecto.Adapters.Postgres
end
