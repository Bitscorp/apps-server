defmodule Apps.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :device_id, :string

      timestamps(type: :utc_datetime)
    end
  end
end
