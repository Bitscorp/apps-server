defmodule Apps.Users.Specs.UserSpec do
  @type t() :: %Apps.Users.User{
          device_id: Types.field(String.t()),
          # timestamps
          inserted_at: Types.field(DateTime.t()),
          updated_at: Types.field(DateTime.t())
        }
end
