defmodule Hui.Repo.Migrations.CreateUserLog do
  use Ecto.Migration

  def change do
    create table(:user_log) do
      add :entity, :string
      add :entity_id, :integer
      add :action, :string
      add :old_value, :string
      add :new_value, :string
      add :user_id, references(:user, on_delete: :nothing)

      timestamps()
    end

    create index(:user_log, [:user_id])
  end
end
