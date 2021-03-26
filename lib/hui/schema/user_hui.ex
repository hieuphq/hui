defmodule Hui.Schema.UserHui do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_hui" do
    field :is_owner, :boolean, default: false
    field :user_id, :id
    field :hui_id, :id

    timestamps()
  end

  @doc false
  def changeset(user_hui, attrs) do
    user_hui
    |> cast(attrs, [:is_owner])
    |> validate_required([:is_owner])
  end
end
