defmodule AppsWeb.SettingsJSON do
  def upsert(%{user_setting: user_setting}) do
    %{
      user_id: user_setting.user_id,
      settings: user_setting.settings
    }
  end
end
