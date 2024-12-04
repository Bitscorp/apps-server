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
        event: %{
          "product_id" => "product_id",
          "expiration_at_ms" => 1_717_238_400_000,
          "type" => "INITIAL_PURCHASE",
          "store" => "APPLE",
          "environment" => "PRODUCTION",
          "app_user_id" => "app_user_id",
          "app_id" => "app_id",
          "event_timestamp_ms" => 1_717_238_400_000,
          "is_trial_conversion" => false,
          "country_code" => "US",
          "price" => 1.0,
          "price_in_purchased_currency" => 1.0,
          "tax_percentage" => 0.0,
          "commission_percentage" => 0.0,
          "takehome_percentage" => 0.0,
          "currency" => "USD"
        },
        user_id: 42
      })
      |> Apps.RevenueCats.create_revenue_cat_event()

    revenue_cat_event
  end
end
