defmodule Hui.Repo.Migrations.CreateUserHui do
  use Ecto.Migration

  def change do
    create table(:user_hui) do
      add :is_owner, :boolean, default: false, null: false
      add :user_id, references(:user, on_delete: :nothing), null: false
      add :hui_id, references(:hui, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:user_hui, [:user_id])
    create index(:user_hui, [:hui_id])
    create unique_index(:user_hui, [:user_id, :hui_id])
  end
end
