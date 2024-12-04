defmodule Apps.Repo.Migrations.AddProjectApiKey do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\""

    alter table(:projects) do
      add :api_key, :string, default: fragment("uuid_generate_v4()"), null: false
    end

    create unique_index(:projects, [:api_key])
  end
end
