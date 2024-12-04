defmodule Apps.RevenueCats.RevenueCatEvent do
  @moduledoc """
  A RevenueCat event.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Apps.RevenueCats.RevenueCatEvent

  @type t() :: Apps.RevenueCats.Specs.RevenueCatEventSpec.t()

  schema "revenue_cat_events" do
    belongs_to :user, Apps.Users.User

    embeds_one :event, Event, primary_key: false, on_replace: :update do
      field :id, :string
      field :app_user_id, :string
      field :app_id, :string
      field :event_timestamp_ms, :integer
      field :product_id, :string
      field :purchased_at_ms, :integer
      field :expiration_at_ms, :integer
      field :store, :string
      field :environment, :string
      field :is_trial_conversion, :boolean
      field :cancel_reason, :string
      field :expiration_reason, :string
      field :new_product_id, :string
      field :transaction_id, :string
      field :type, :string
      field :period_type, :string
      field :country_code, :string
      field :price, :float
      field :price_in_purchased_currency, :float
      field :tax_percentage, :float
      field :commission_percentage, :float
      field :takehome_percentage, :float
      field :currency, :string
    end

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(revenue_cat_event, attrs) do
    revenue_cat_event
    |> cast(attrs, [:user_id])
    |> cast_embed(:event, with: &event_changeset/2)
    |> validate_required([:user_id, :event])
    |> foreign_key_constraint(:user_id)
  end

  defp event_changeset(%RevenueCatEvent.Event{} = event, attrs) do
    event
    |> cast(attrs, [
      :id,
      :app_id,
      :app_user_id,
      :event_timestamp_ms,
      :product_id,
      :purchased_at_ms,
      :expiration_at_ms,
      :store,
      :environment,
      :is_trial_conversion,
      :cancel_reason,
      :expiration_reason,
      :new_product_id,
      :transaction_id,
      :type,
      :period_type,
      :country_code,
      :price,
      :price_in_purchased_currency,
      :tax_percentage,
      :commission_percentage,
      :takehome_percentage,
      :currency
    ])
  end
end
