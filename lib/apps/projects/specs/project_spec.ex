defmodule Apps.Projects.Specs.ProjectSpec do
  @moduledoc false

  alias Apps.Types

  @type t() :: %Apps.Projects.Project{
          # attributes
          name: Types.field(String.t()),
          platform: Types.field(String.t()),
          api_key: Types.field(String.t()),

          # associations
          users: [Specs.UserSpec.t()],

          # timestamps
          inserted_at: Types.field(DateTime.t()),
          updated_at: Types.field(DateTime.t())
        }
end
