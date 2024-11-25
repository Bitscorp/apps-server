defmodule Apps.ProjectsTest do
  use Apps.DataCase

  alias Apps.Projects

  describe "projects" do
    alias Apps.Projects.Project

    import Apps.ProjectsFixtures

    @invalid_attrs %{name: nil, platform: nil}

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Projects.get_project!(project.id) == project
    end
  end
end
