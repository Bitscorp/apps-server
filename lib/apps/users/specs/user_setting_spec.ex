defmodule Apps.Users.Specs.UserSettingSpec do
  @moduledoc false

  alias Apps.Types

  @type t() :: %Apps.Users.UserSetting{
          settings: Types.field(map()),
          user_id: Types.field(integer()),

          # associations
          user: Apps.Users.Specs.UserSpec.t(),

          # timestamps
          inserted_at: Types.field(DateTime.t()),
          updated_at: Types.field(DateTime.t())
        }
end
