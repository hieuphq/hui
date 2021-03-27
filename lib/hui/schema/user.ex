defmodule Hui.Schema.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field :email, :string
    field :identity, :string
    field :identity_type, :string
    field :phone, :string
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

  def create_changeset(attrs, type) do
    attrs =
      attrs
      |> Map.put("status", "active")
      |> Map.put("identity_type", Atom.to_string(type))
      |> attach_identity(type, Map.get(attrs, "identity", nil))

    %__MODULE__{}
    |> cast(attrs, [:name, :email, :phone, :identity, :password, :status, :identity_type])
    |> validate_required([:name, :identity, :password, :status, :identity_type])
    |> unique_constraint(:email)
    |> unique_constraint(:phone)
    |> hash_password()
  end

  defp attach_identity(attrs, :email, val) do
    Map.put(attrs, "email", val)
  end

  defp attach_identity(attrs, :phone, val) do
    Map.put(attrs, "phone", val)
  end

  defp attach_identity(attrs, _type, _val) do
    attrs
  end

  defp hash_password(%{valid?: true, changes: %{password: password}} = changeset) do
    put_change(changeset, :hashed_password, Bcrypt.hash_pwd_salt(password))
  end

  defp hash_password(changeset), do: changeset
end
