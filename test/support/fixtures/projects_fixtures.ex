defmodule Apps.ProjectsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Apps.Projects` context.
  """

  @doc """
  Generate a project.
  """
  def project_fixture(attrs \\ %{}) do
    {:ok, project} =
      attrs
      |> Enum.into(%{
        name: "some name",
        platform: "some platform",
        api_key: "key1"
      })
      |> Apps.Projects.create_project()

    project
  end
end
