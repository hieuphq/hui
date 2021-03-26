defmodule Hui.Schema.UserLog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_log" do
    field :action, :string
    field :entity, :string
    field :entity_id, :integer
    field :new_value, :string
    field :old_value, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(user_log, attrs) do
    user_log
    |> cast(attrs, [:entity, :id, :action, :old_value, :new_value])
    |> validate_required([:entity, :id, :action, :old_value, :new_value])
  end
end
