defmodule Apps.RevenueCats.Specs.RevenueCatEventSpec do
  @moduledoc false

  alias Apps.Types

  @type t() :: %Apps.RevenueCats.RevenueCatEvent{
          user_id: Types.field(integer()),
          event: Apps.RevenueCatsSpecs.EventSpec.t(),

          # associations
          user: Apps.Users.Specs.UserSpec.t(),

          # timestamps
          inserted_at: Types.field(DateTime.t()),
          updated_at: Types.field(DateTime.t())
        }
end
