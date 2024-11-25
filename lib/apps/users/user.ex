defmodule Apps.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @type t() :: Specs.UserSpec.t()

  schema "users" do
    field :device_id, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:device_id])
    |> validate_required([:device_id])
  end
end
