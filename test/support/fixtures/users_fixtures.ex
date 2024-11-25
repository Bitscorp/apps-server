defmodule Apps.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Apps.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    attrs =
      case attrs do
        %{project_id: _project_id} ->
          attrs

        _ ->
          attrs |> Map.put(:project_id, Apps.ProjectsFixtures.project_fixture().id)
      end

    {:ok, user} =
      attrs
      |> Enum.into(%{
        device_id: "some device_id"
      })
      |> Apps.Users.create_user()

    user
  end

  @doc """
  Generate a user_setting.
  """
  def user_setting_fixture(attrs \\ %{}) do
    {:ok, user_setting} =
      attrs
      |> Enum.into(%{
        settings: %{}
      })
      |> Apps.Users.create_user_setting()

    user_setting
  end
end
