defmodule Apps.ProjectsTest do
  use Apps.DataCase

  alias Apps.Projects

  describe "projects" do
    import Apps.ProjectsFixtures

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()

      created_project = Projects.get_project!(project.id)

      assert created_project.id == project.id
      assert created_project.name == project.name
      assert created_project.platform == project.platform
      assert created_project.api_key != nil
    end
  end
end
