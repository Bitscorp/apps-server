defmodule Apps.Repo.Migrations.CreateDefaultProjects do
  use Ecto.Migration

  def change do
    execute """
    INSERT INTO projects (platform, name, inserted_at, updated_at) VALUES
      ('ios', 'Cat Verbs', NOW(), NOW()),
      ('android', 'Cat Verbs', NOW(), NOW()),
      ('ios', 'Spanish Verbs', NOW(), NOW()),
      ('android', 'Spanish Verbs', NOW(), NOW()),
      ('ios', 'French Verbs', NOW(), NOW()),
      ('android', 'French Verbs', NOW(), NOW()),
      ('ios', 'Palm Reader AI', NOW(), NOW()),
      ('android', 'Palm Reader AI', NOW(), NOW()),
      ('ios', 'Calories Planner AI', NOW(), NOW()),
      ('android', 'Calories Planner AI', NOW(), NOW()),
      ('ios', 'Tarot AI', NOW(), NOW()),
      ('android', 'Tarot AI', NOW(), NOW())
    ;
    """

  end
end
