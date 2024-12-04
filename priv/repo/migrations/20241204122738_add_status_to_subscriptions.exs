defmodule Apps.Repo.Migrations.AddStatusToSubscriptions do
  use Ecto.Migration

  def change do
    alter table(:subscriptions) do
      add :status, :string, null: false, default: "active"
    end
  end
end
