defmodule Hui.Currency do
  alias Hui.Schema.Currency
  alias Hui.Repo

  @default "vnd"

  def get_by_code(code \\ @default) do
    Repo.get_by(Currency, code: code)
  end
end
