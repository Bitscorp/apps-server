defmodule Apps.Release do
  @moduledoc false

  @app :apps

  @start_apps [
    :postgrex,
    :ecto,
    :apps
  ]

  def createdb do
    ensure_started()

    prepare()

    for repo <- repos() do
      :ok = ensure_repo_created(repo)
    end
  end

  @doc """
  bin/start_server eval 'EyelevelEx.Release.migrate()'
  """
  def migrate do
    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  @doc """
  bin/start_server eval 'EyelevelEx.Release.rollback(repo, version)'
  """
  def rollback(repo, version) do
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  @doc """
  bin/start_server eval 'EyelevelEx.Release.seed()'
  bin/start_server eval 'EyelevelEx.Release.seed("seeds/articles.exs")'
  """
  def seed, do: seed("seeds.exs")

  def seed(filename) do
    filename = Application.app_dir(@app, "priv/repo/#{filename}")

    for repo <- repos() do
      {:ok, _, _} =
        Ecto.Migrator.with_repo(repo, fn _repo ->
          if File.regular?(filename) do
            {:ok, Code.eval_file(filename)}
          else
            {:error, "Seeds file not found."}
          end
        end)
    end
  end

  defp start_minimal do
    Application.ensure_all_started(:ssl)
    Application.load(@app)
  end

  defp repos do
    start_minimal()
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp ensure_started do
    Application.ensure_all_started(:ssl)
  end

  defp ensure_repo_created(repo) do
    IO.puts("create #{inspect(repo)} database if it doesn't exist")

    case repo.__adapter__.storage_up(repo.config) do
      :ok -> :ok
      {:error, :already_up} -> :ok
      {:error, term} -> {:error, term}
    end
  end

  defp prepare do
    IO.puts("Loading #{@app}..")
    :ok = Application.load(@app)

    IO.puts("Starting dependencies..")
    Enum.each(@start_apps, &Application.ensure_all_started/1)

    IO.puts("Starting repos..")
    Enum.each(repos(), & &1.start_link(pool_size: 2))
  end
end
