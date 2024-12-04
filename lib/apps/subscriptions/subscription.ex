defmodule Apps.Subscriptions.Subscription do
  @moduledoc """
  A subscription is a user's active subscription to a product.

  event types:
  - "EXPIRATION"
  - "CANCELLATION"
  - "INITIAL_PURCHASE"
  - "RENEWAL"
  - "UNCANCELLATION"
  - "SUBSCRIPTION_EXTENDED"
  - "NON_RENEWING_PURCHASE"
  - "PRODUCT_CHANGE"
  - "TEST"
  - "TRANSFER"
  - "SUBSCRIPTION_PAUSED"
  - "SUBSCRIBER_ALIAS"
  - "BILLING_ISSUE"

  status:
  - cancelled
  - active
  - expired
  - billing_issue
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Apps.Users.User

  @type t() :: Specs.SubscriptionSpec.t()

  schema "subscriptions" do
    field :status, :string, default: "active"

    field :product_id, :string

    field :expires_at, EctoUnixTimestamp,
      unit: :millisecond,
      underlying_type: :utc_datetime

    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  def changeset(subscription, attrs) do
    subscription
    |> cast(attrs, [:product_id, :expires_at, :user_id, :status])
    |> validate_required([:product_id,  :user_id])
    |> assoc_constraint(:user)
    |> unique_constraint([:product_id, :user_id])
  end
end
