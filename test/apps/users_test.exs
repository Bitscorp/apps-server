defmodule Apps.UsersTest do
  use Apps.DataCase

  alias Apps.Users

  describe "users" do
    alias Apps.Users.User

    import Apps.UsersFixtures

    setup do
      Repo.delete_all(User)

      :ok
    end

    test "upsert_user/1 creates a user" do
      user = user_fixture(%{device_id: "device_id"})
      assert user.device_id == "device_id"
    end

    test "upsert_user/1 updates a user" do
      user = user_fixture(%{device_id: "device_id"})
      assert user.device_id == "device_id"

      {:ok, user} = Users.upsert_user(%{device_id: "device_id", name: "name", project_id: user.project_id})
      assert user.device_id == "device_id"

      assert User |> Repo.aggregate(:count) == 1
    end
  end
end
