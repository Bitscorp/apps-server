defmodule Apps.Repo.Migrations.AddProjectsAssocToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :project_id, references(:projects, on_delete: :delete_all)
    end

    drop unique_index(:users, [:device_id])
    create unique_index(:users, [:project_id, :device_id])
  end
end
