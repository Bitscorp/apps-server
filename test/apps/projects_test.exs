defmodule Apps.ProjectsTest do
  use Apps.DataCase

  alias Apps.Projects

  describe "projects" do
    import Apps.ProjectsFixtures

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Projects.get_project!(project.id) == project
    end
  end
end
