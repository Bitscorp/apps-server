defmodule Apps.RevenueCats.Specs.EventSpec do
  @moduledoc false

  alias Apps.Types

  @type t() :: %Apps.RevenueCats.RevenueCatEvent.Event{
          id: Types.field(String.t()),
          app_id: Types.field(String.t()),
          event_timestamp_ms: Types.field(integer()),
          product_id: Types.field(String.t()),
          purchased_at_ms: Types.field(integer()),
          expiration_at_ms: Types.field(integer()),
          store: Types.field(String.t()),
          environment: Types.field(String.t()),
          is_trial_conversion: Types.field(boolean()),
          cancel_reason: Types.field(String.t()),
          expiration_reason: Types.field(String.t()),
          new_product_id: Types.field(String.t()),
          transaction_id: Types.field(String.t()),
          type: Types.field(String.t()),
          period_type: Types.field(String.t()),
          country_code: Types.field(String.t()),
          price: Types.field(float()),
          price_in_purchased_currency: Types.field(float()),
          tax_percentage: Types.field(float()),
          commission_percentage: Types.field(float()),
          takehome_percentage: Types.field(float()),
          currency: Types.field(String.t())
        }
end
