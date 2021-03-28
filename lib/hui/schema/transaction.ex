defmodule Hui.Schema.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transaction" do
    field :amount, :decimal
    field :currency_rate, :decimal
    field :note, :string
    field :type, :string
    field :user_id, :id
    field :hui_id, :id
    field :currency_id, :id
    field :created_by_id, :id

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:type, :note, :amount, :currency_rate])
    |> validate_required([:type, :note, :amount, :currency_rate])
  end

  def deposit_changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:type, :note, :amount, :currency_id, :user_id, :hui_id, :created_by_id])
    |> validate_required([:type, :amount, :currency_id, :user_id, :hui_id, :created_by_id])
    |> validate_number(:amount, greater_than: 0)
  end
end
