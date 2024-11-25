defmodule Apps.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :platform, :string
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
