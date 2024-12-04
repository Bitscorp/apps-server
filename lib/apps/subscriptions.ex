defmodule Apps.Subscriptions do
  @moduledoc """
  The Subscriptions context.
  """

  import Ecto.Query, warn: false

  alias Apps.Repo
  alias Apps.Subscriptions.Subscription

  require Logger

  def create_subscription(attrs) do
    %Subscription{}
    |> Subscription.changeset(attrs)
    |> Repo.insert()
  end

  def upsert_subscription(event, attrs) do
    case event.event.type do
      event_type when event_type in ["INITIAL_PURCHASE", "NON_RENEWING_PURCHASE"] ->
        attrs
        |> Map.put("status", "active")
        |> update_subscription()

      "CANCELLATION" ->
        attrs
        |> Map.put("status", "cancelled")
        |> update_subscription()

      "EXPIRATION" ->
        attrs
        |> Map.put("status", "expired")
        |> update_subscription()

      "BILLING_ISSUE" ->
        attrs
        |> Map.put("status", "billing_issue")
        |> update_subscription()

      _ ->
        Logger.error("Unknown event type: #{inspect(event.event)}")

        {:error, :unknown_event_type}
    end
  end

  def update_subscription(attrs) do
    %Subscription{}
    |> Subscription.changeset(attrs)
    |> Repo.insert(
      on_conflict: {:replace, [:expires_at, :status]},
      conflict_target: [:product_id, :user_id]
    )
  end
end
