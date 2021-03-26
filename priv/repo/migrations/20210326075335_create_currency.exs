defmodule Hui.Repo.Migrations.CreateCurrency do
  use Ecto.Migration

  def change do
    create table(:currency) do
      add :name, :string
      add :code, :string

      timestamps()
    end

  end
end
