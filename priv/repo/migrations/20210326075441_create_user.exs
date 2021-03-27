defmodule Hui.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :name, :string, null: false
      add :identity, :string, null: false
      add :identity_type, :string, null: false
      add :phone, :string
      add :email, :string
      add :hashed_password, :string, null: false
      add :status, :string, null: false

      timestamps()
    end

    create unique_index(:user, [:email], where: "email IS NOT NULL")
    create unique_index(:user, [:phone], where: "phone IS NOT NULL")
  end
end
