defmodule Apps.RevenueCatsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Apps.RevenueCats` context.
  """

  @doc """
  Generate a revenue_cat_event.
  """
  def revenue_cat_event_fixture(attrs \\ %{}) do
    {:ok, revenue_cat_event} =
      attrs
      |> Enum.into(%{
        event: %{},
        user_id: 42
      })
      |> Apps.RevenueCats.create_revenue_cat_event()

    revenue_cat_event
  end
end
