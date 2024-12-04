defmodule Apps.SubscriptionsTest do
  use Apps.DataCase

  alias Apps.Subscriptions
  alias Apps.Subscriptions.Subscription
  alias Apps.RevenueCats.RevenueCatEvent
  alias Apps.Users.User
  alias Apps.Repo

  describe "subscriptions" do
    import Apps.UsersFixtures
    import Apps.SubscriptionsFixtures
    import Apps.RevenueCatsFixtures

    setup do
      Repo.delete_all(RevenueCatEvent)
      Repo.delete_all(User)
      Repo.delete_all(Subscription)

      user = user_fixture(%{device_id: "device_id"})

      %{user: user}
    end

    test "upsert_subscription/1 creates a subscription", %{user: user} do
      event =
        revenue_cat_event_fixture(%{
          user_id: user.id
        })

      {:ok, subscription} =
        Subscriptions.upsert_subscription(
          event,
          %{
            "product_id" => "product_id",
            "user_id" => user.id,
            "expires_at" => 1_717_238_400_000
          }
        )

      assert subscription.product_id == "product_id"

      assert subscription.user_id == user.id
      assert subscription.expires_at == ~U[2024-06-01 10:40:00.000Z]

      assert subscription.status == "active"
    end

    test "upsert_subscription/1 updates a subscription and can't create one more record in db", %{
      user: user
    } do
      assert Repo.aggregate(Subscription, :count) == 0

      event =
        revenue_cat_event_fixture(%{
          user_id: user.id
        })

      existing_subscription =
        subscription_fixture(%{
          user_id: user.id,
          product_id: "product_id"
        })

      {:ok, subscription} =
        Subscriptions.upsert_subscription(
          event,
          %{
            "product_id" => "product_id",
            "expires_at" => 1_717_238_400_000,
            "user_id" => user.id
          }
        )

      assert subscription.id == existing_subscription.id
      assert subscription.product_id == "product_id"
      assert subscription.user_id == user.id
      assert subscription.expires_at == ~U[2024-06-01 10:40:00.000Z]
      assert subscription.status == "active"

      assert Repo.aggregate(Subscription, :count) == 1
    end

    test "upsert_subscription/1 fails if product_id is missing", %{user: user} do
      event =
        revenue_cat_event_fixture(%{
          user_id: user.id
        })

      assert {:error, changeset} =
               Subscriptions.upsert_subscription(
                 event,
                 %{
                   "user_id" => user.id,
                   "expires_at" => 1_717_238_400_000
                 }
               )

      assert "can't be blank" in errors_on(changeset).product_id
    end

    test "upsert_subscription/1 fails if user_id is missing", %{user: user} do
      event = revenue_cat_event_fixture(%{user_id: user.id})

      assert {:error, changeset} =
               Subscriptions.upsert_subscription(
                 event,
                 %{
                   "product_id" => "product_id",
                   "expires_at" => 1_717_238_400_000
                 }
               )

      assert "can't be blank" in errors_on(changeset).user_id
    end

    test "upsert_subscription/1 creates only if event has INITIAL_PURCHASE or NON_RENEWING_PURCHASE",
         %{
           user: user
         } do
      event = revenue_cat_event_fixture(%{user_id: user.id, event: %{type: "CANCELLATION"}})

      assert Repo.aggregate(Subscription, :count) == 0

      Subscriptions.upsert_subscription(
        event,
        %{
          "product_id" => "product_id",
          "user_id" => user.id,
          "expires_at" => 1_717_238_400_000
        }
      )

      event =
        revenue_cat_event_fixture(%{user_id: user.id, event: %{type: "NON_RENEWING_PURCHASE"}})

      Subscriptions.upsert_subscription(
        event,
        %{
          "product_id" => "product_id",
          "user_id" => user.id,
          "expires_at" => 1_717_238_400_000
        }
      )

      assert Repo.aggregate(Subscription, :count) == 1
    end

    test "upsert_subscription/1 updates status of a subscription", %{user: user} do
      event = revenue_cat_event_fixture(%{user_id: user.id, event: %{type: "INITIAL_PURCHASE"}})

      {:ok, subscription} =
        Subscriptions.upsert_subscription(
          event,
          %{
            "product_id" => "product_id",
            "user_id" => user.id,
            "expires_at" => 1_717_238_400_000
          }
        )

      assert subscription.status == "active"

      event = revenue_cat_event_fixture(%{user_id: user.id, event: %{type: "CANCELLATION"}})

      {:ok, subscription} =
        Subscriptions.upsert_subscription(
          event,
          %{
            "product_id" => "product_id",
            "user_id" => user.id,
            "expires_at" => 1_717_238_400_000
          }
        )

      assert subscription.status == "cancelled"
    end
  end
end
