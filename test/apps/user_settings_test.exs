defmodule Apps.UserSettingsTest do
  use Apps.DataCase

  alias Apps.Users
  alias Apps.Users.UserSetting

  describe "users" do
    alias Apps.Users.User

    import Apps.UsersFixtures

    setup do
      Repo.delete_all(User)
      Repo.delete_all(UserSetting)
      :ok
    end

    test "create_user_setting/1 creates a user setting" do
      user = user_fixture(%{device_id: "device_id"})
      assert user.device_id == "device_id"

      {:ok, user_setting} = Users.create_user_setting(%{user_id: user.id, settings: %{}})
      assert user_setting.user_id == user.id
      assert user_setting.settings == %{}
    end

    test "upsert_settings/1 upserts a user setting" do
      user = user_fixture(%{device_id: "device_id"})
      assert user.device_id == "device_id"

      {:ok, user_setting} = Users.upsert_settings(%{user_id: user.id, settings: %{}})
      assert user_setting.user_id == user.id
      assert user_setting.settings == %{}

      {:ok, user_setting} = Users.upsert_settings(%{user_id: user.id, settings: %{key: "value"}})
      assert user_setting.user_id == user.id
      assert user_setting.settings == %{key: "value"}

      assert UserSetting |> Repo.aggregate(:count) == 1
    end
  end
end
