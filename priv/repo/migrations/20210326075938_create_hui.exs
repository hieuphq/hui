defmodule Hui.Repo.Migrations.CreateHui do
  use Ecto.Migration

  def change do
    create table(:hui) do
      add :name, :string
      add :currency_id, references(:currency, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:hui, [:currency_id])
  end
end
