defmodule Hui.Repo.Migrations.CreateCurrency do
  use Ecto.Migration

  def change do
    create table(:currency) do
      add :name, :string, null: false
      add :code, :string, null: false
      add :symbol, :string, null: false

      timestamps()
    end

  end
end
