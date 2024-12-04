defmodule Apps.Repo.Migrations.AddProductExpiresAtToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :product_expires_at, :utc_datetime
    end
  end
end
