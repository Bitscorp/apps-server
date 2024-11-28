defmodule Apps.RevenueCats.Specs.RevenueCatEventSpec do
  @moduledoc false

  @type t() :: %Apps.RevenueCats.RevenueCatEvent{
          user_id: Types.field(integer()),
          event: Specs.EventSpec.t(),

          # associations
          user: Specs.UserSpec.t(),

          # timestamps
          inserted_at: Types.field(DateTime.t()),
          updated_at: Types.field(DateTime.t())
        }
end
