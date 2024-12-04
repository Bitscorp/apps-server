defmodule Apps.Repo.Migrations.CreateSubscriptions do
  use Ecto.Migration

  def change do
    create table(:subscriptions) do
      add :user_id, references(:users, on_delete: :delete_all)

      # attributes
      add :product_id, :string
      add :expires_at, :utc_datetime

      timestamps(type: :utc_datetime)
    end

    create index(:subscriptions, [:user_id])
    create unique_index(:subscriptions, [:product_id, :user_id], name: :subscriptions_product_user_unique_index)
  end
end
