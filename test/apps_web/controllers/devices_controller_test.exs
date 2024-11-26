defmodule AppsWeb.DevicesControllerTest do
  use AppsWeb.ConnCase

  alias Apps.Repo
  alias Apps.Users.User

  setup do
    project = Apps.ProjectsFixtures.project_fixture()

    %{project: project}
  end

  describe "creates a user" do
    test "POST /", %{conn: conn, project: project} do
      conn = post(conn, ~p"/projects/#{project.id}/devices/1")
      assert json_response(conn, 200) == %{"device_id" => "1"}

      conn = post(conn, ~p"/projects/#{project.id}/devices/1")
      assert json_response(conn, 200) == %{"device_id" => "1"}

      users = User |> Repo.all()
      assert Enum.count(users) == 1

      user = users |> List.first()
      assert user.project_id == project.id
      assert user.device_id == "1"
    end
  end
end
