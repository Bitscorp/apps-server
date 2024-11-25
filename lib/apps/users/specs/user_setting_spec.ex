defmodule Apps.Users.Specs.UserSettingSpec do
  @type t() :: %Apps.Users.UserSetting{
          settings: Types.field(map()),
          user_id: Types.field(integer()),

          # associations
          user: Specs.UserSpec.t(),

          # timestamps
          inserted_at: Types.field(DateTime.t()),
          updated_at: Types.field(DateTime.t())
        }
end
