defmodule Apps.Repo.Migrations.AddDeviceIdUniqueConstraint do
  use Ecto.Migration

  def change do
    create unique_index(:users, [:device_id])
  end
end
