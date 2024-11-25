defmodule Apps.Users.UserSetting do
  use Ecto.Schema
  import Ecto.Changeset

  @type t() :: Specs.UserSettingSpec.t()

  schema "user_settings" do
    field :settings, :map

    belongs_to :user, Apps.Users.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user_setting, attrs) do
    user_setting
    |> cast(attrs, [:settings, :user_id])
    |> validate_required([:settings])
    |> assoc_constraint(:user)
  end
end
