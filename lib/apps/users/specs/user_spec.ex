defmodule Apps.Users.Specs.UserSpec do
  @moduledoc false

  @type t() :: %Apps.Users.User{
          device_id: Types.field(String.t()),
          project_id: Types.field(integer()),

          # associations
          user_setting: Specs.UserSettingSpec.t(),
          project: Specs.ProjectSpec.t(),

          # timestamps
          inserted_at: Types.field(DateTime.t()),
          updated_at: Types.field(DateTime.t())
        }
end
