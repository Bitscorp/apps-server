defmodule Apps.Types do
  @type id() :: binary() | integer()
  @type uuid() :: Ecto.UUID.t()
  @type field(field_type) :: field_type | nil
  @type assoc_field(schema_type) :: schema_type | Ecto.Association.NotLoaded.t() | nil
end
