defmodule Apps.RevenueCatsTest do
  use Apps.DataCase

  alias Apps.RevenueCats

  describe "revenue_cat_events" do
    alias Apps.RevenueCats.RevenueCatEvent
    alias Apps.Users.User
    alias Apps.Repo

    import Apps.RevenueCatsFixtures

    @invalid_attrs %{user_id: nil, event: nil}

    setup do
      Repo.delete_all(RevenueCatEvent)
      Repo.delete_all(User)

      user = Apps.UsersFixtures.user_fixture()

      %{user: user}
    end

    test "create_revenue_cat_event/1 with valid data creates a revenue_cat_event", %{user: user} do
      valid_attrs = %{user_id: user.id, event: %{product_id: "test1"}}

      assert {:ok, %RevenueCatEvent{} = revenue_cat_event} =
               RevenueCats.create_revenue_cat_event(valid_attrs)

      assert revenue_cat_event.user_id == user.id
      assert revenue_cat_event.event.product_id == "test1"
    end

    test "create_revenue_cat_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RevenueCats.create_revenue_cat_event(@invalid_attrs)
    end
  end
end
