defmodule Hui.Schema.Hui do
  use Ecto.Schema
  import Ecto.Changeset

  schema "hui" do
    field :name, :string
    field :currency_id, :id

    timestamps()
  end

  @doc false
  def changeset(hui, attrs) do
    hui
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def create_changeset(hui, attrs) do
    hui
    |> cast(attrs, [:name, :currency_id])
    |> validate_required([:name, :currency_id])
  end
end
