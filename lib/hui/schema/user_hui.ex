defmodule Hui.Schema.UserHui do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_hui" do
    field :is_owner, :boolean, default: false
    field :user_id, :id
    field :hui_id, :id
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(user_hui, attrs) do
    user_hui
    |> cast(attrs, [:user_id, :hui_id, :is_owner, :status])
    |> validate_required([:user_id, :hui_id, :is_owner, :status])
  end
end
