defmodule AppsWeb.RevenueCatControllerTest do
  use AppsWeb.ConnCase

  alias Apps.Repo
  alias Apps.Projects.Project
  alias Apps.Users.User
  alias Apps.RevenueCats.RevenueCatEvent

  setup do
    RevenueCatEvent |> Repo.delete_all()
    User |> Repo.delete_all()
    Project |> Repo.delete_all()

    project = Apps.ProjectsFixtures.project_fixture()
    user = Apps.UsersFixtures.user_fixture(%{project_id: project.id})

    %{project: project, user: user}
  end

  describe "creates a user" do
    test "POST /", %{conn: conn, project: project, user: user} do
      conn =
        post(conn, ~p"/projects/#{project.id}/revenue_cat/webhook", %{
          event: %{
            product_id: "test1",
            app_user_id: user.id
          }
        })

      assert json_response(conn, 200) == %{
               "user_id" => user.id
             }

      event = RevenueCatEvent |> Repo.one()
      assert event.user_id == user.id
      assert event.event.product_id == "test1"
      assert event.event.app_user_id == user.id
    end
  end
end
