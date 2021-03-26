defmodule Hui.Schema.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field :email, :string
    field :hashed_password, :string
    field :name, :string
    field :status, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :hashed_password, :status])
    |> validate_required([:name, :email, :hashed_password, :status])
  end

  def create_changeset(attrs) do
    attrs = Map.put(attrs, "status", "active")

    %__MODULE__{}
    |> cast(attrs, [:name, :email, :password, :status])
    |> validate_required([:name, :email, :password, :status])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> hash_password()
  end

  defp hash_password(%{valid?: true, changes: %{password: password}} = changeset) do
    put_change(changeset, :hashed_password, Bcrypt.hash_pwd_salt(password))
  end

  defp hash_password(changeset), do: changeset
end
