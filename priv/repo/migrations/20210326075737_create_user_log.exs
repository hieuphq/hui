defmodule Hui.Repo.Migrations.CreateUserLog do
  use Ecto.Migration

  def change do
    create table(:user_log) do
      add :entity, :string, null: false
      add :entity_id, :integer, null: false
      add :action, :string, null: false
      add :old_value, :string
      add :new_value, :string
      add :user_id, references(:user, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:user_log, [:user_id])
  end
end
