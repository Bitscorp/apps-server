defmodule Apps.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Apps.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        device_id: "some device_id"
      })
      |> Apps.Users.create_user()
    user
  end
end
