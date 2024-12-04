defmodule Apps.Subscriptions.Specs.SubscriptionSpec do
  @moduledoc false

  alias Apps.Types

  @type t() :: %Apps.Subscriptions.Subscription{
          id: Types.field(String.t()),

          # associations
          user_id: Types.field(integer()),
          user: Apps.Users.Specs.UserSpec.t(),

          # attributes
          product_id: Types.field(String.t()),
          expires_at: Types.field(DateTime.t()),
          status: Types.field(String.t())
        }
end
