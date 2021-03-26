defmodule Hui.Repo.Migrations.CreateTransaction do
  use Ecto.Migration

  def change do
    create table(:transaction) do
      add :type, :string
      add :note, :string
      add :amount, :decimal
      add :currency_rate, :decimal
      add :user_id, references(:user, on_delete: :nothing), null: false
      add :hui_id, references(:hui, on_delete: :nothing), null: false
      add :currency_id, references(:currency, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:transaction, [:user_id])
    create index(:transaction, [:hui_id])
    create index(:transaction, [:currency_id])
  end
end
