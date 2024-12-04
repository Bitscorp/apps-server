defmodule Apps.SubscriptionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Apps.Subscriptions` context.
  """

  @doc """
  Generate a subscription.
  """
  def subscription_fixture(attrs \\ %{}) do
    attrs =
      case attrs do
        %{user_id: _user_id} ->
          attrs

        _ ->
          attrs |> Map.put(:user_id, Apps.UsersFixtures.user_fixture().id)
      end

    {:ok, subscription} =
      attrs
      |> Enum.into(%{
        product_id: "some product_id",
        # by default we are passing ms timestamp
        expires_at: 1_717_238_400_000
      })
      |> Apps.Subscriptions.create_subscription()

    subscription
  end
end
