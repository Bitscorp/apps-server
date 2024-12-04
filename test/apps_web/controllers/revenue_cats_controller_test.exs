defmodule AppsWeb.RevenueCatControllerTest do
  @moduledoc false

  use AppsWeb.ConnCase

  alias Apps.Repo
  alias Apps.Projects.Project
  alias Apps.Users.User
  alias Apps.RevenueCats.RevenueCatEvent
  alias Apps.Subscriptions.Subscription

  setup do
    Repo.delete_all(RevenueCatEvent)
    Repo.delete_all(Subscription)
    Repo.delete_all(User)
    Repo.delete_all(Project)

    project = Apps.ProjectsFixtures.project_fixture()
    user = Apps.UsersFixtures.user_fixture(%{project_id: project.id})

    %{project: project, user: user}
  end

  describe "creates revenue cat event" do
    test "POST /webhook creates a revenue cat event", %{conn: conn, project: project, user: user} do
      conn =
        post(conn, ~p"/projects/#{project.id}/revenue_cat/webhook", %{
          event: %{
            "product_id" => "test1",
            "expiration_at_ms" => 1_717_238_400_000,
            "app_user_id" => user.id |> to_string(),
            "type" => "INITIAL_PURCHASE"
          }
        })

      assert json_response(conn, 200) == %{
               "user_id" => user.id
             }

      event = RevenueCatEvent |> Repo.one()
      assert event.user_id == user.id
      assert event.event.product_id == "test1"
      assert event.event.app_user_id == user.id |> to_string()
    end

    test "POST /webhook creates a subscription", %{conn: conn, project: project, user: user} do
      assert Repo.aggregate(Subscription, :count) == 0

      conn =
        post(conn, ~p"/projects/#{project.id}/revenue_cat/webhook", %{
          event: %{
            "type" => "INITIAL_PURCHASE",
            "product_id" => "test1",
            "app_user_id" => user.id |> to_string(),
            "expiration_at_ms" => 1_717_238_400_000
          }
        })

      assert json_response(conn, 200) == %{
               "user_id" => user.id
             }

      subscription = Apps.Subscriptions.Subscription |> Repo.one()
      assert subscription.user_id == user.id
      assert subscription.product_id == "test1"
      assert subscription.expires_at == ~U[2024-06-01 10:40:00Z]
    end

    test "POST /webhook should expires a subscription", %{
      conn: conn,
      project: project,
      user: user
    } do
      Apps.SubscriptionsFixtures.subscription_fixture(%{
        user_id: user.id,
        product_id: "test1"
      })

      assert Repo.aggregate(Subscription, :count) == 1

      conn =
        post(conn, ~p"/projects/#{project.id}/revenue_cat/webhook", %{
          event: %{
            "type" => "EXPIRATION",
            "product_id" => "test1",
            "app_user_id" => user.id |> to_string()
          }
        })

      assert json_response(conn, 200) == %{
               "user_id" => user.id
             }

      subscription = Apps.Subscriptions.Subscription |> Repo.one()
      assert subscription.status == "expired"
    end
  end
end
