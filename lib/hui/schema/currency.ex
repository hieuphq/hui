defmodule Hui.Schema.Currency do
  use Ecto.Schema
  import Ecto.Changeset

  schema "currency" do
    field :code, :string
    field :name, :string
    field :symbol, :string

    timestamps()
  end

  @doc false
  def changeset(currency, attrs) do
    currency
    |> cast(attrs, [:name, :code])
    |> validate_required([:name, :code])
  end
end
