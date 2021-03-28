defmodule Hui.Transaction.TransactionDeposit do
  alias Hui.Schema.Transaction
  alias Hui.Repo

  def create(created_by, %{id: hui_id, currency_id: currency_id} = _hui, user_id, params) do
    params =
      %{
        "hui_id" => hui_id,
        "currency_id" => currency_id,
        "user_id" => user_id,
        "type" => "deposit",
        "created_by_id" => created_by
      }
      |> Map.merge(params)

    Transaction.deposit_changeset(%Transaction{}, params)
    |> Repo.insert()
  end
end
