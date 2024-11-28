defmodule Apps.Projects.Specs.ProjectSpec do
  @moduledoc false

  @type t() :: %Apps.Projects.Project{
          name: Types.field(String.t()),
          platform: Types.field(String.t()),

          # associations
          users: [Specs.UserSpec.t()],

          # timestamps
          inserted_at: Types.field(DateTime.t()),
          updated_at: Types.field(DateTime.t())
        }
end
