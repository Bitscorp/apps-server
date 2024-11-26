defmodule Apps.Repo.Migrations.CreateRevenueCatEvents do
  use Ecto.Migration

  def change do
    create table(:revenue_cat_events) do
      add :user_id, references(:users, on_delete: :nothing)
      add :event, :map

      timestamps(type: :utc_datetime)
    end

    create index(:revenue_cat_events, [:user_id])
  end
end
