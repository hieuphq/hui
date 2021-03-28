defmodule HuiWeb.TransactionView do
  use HuiWeb, :view

  def render("deposit.json", %{transaction: transaction}) do
    %{
      id: transaction.id,
      amount: transaction.amount,
      type: transaction.type,
      note: transaction.note,
      user_id: transaction.user_id,
      hui_id: transaction.hui_id,
      currency_id: transaction.currency_id,
      created_by_id: transaction.created_by_id
    }
  end
end
