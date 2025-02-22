defmodule Apps.Users.User do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @type t() :: Apps.Users.Specs.UserSpec.t()

  schema "users" do
    field :device_id, :string

    field :product_expires_at, EctoUnixTimestamp,
      unit: :millisecond,
      underlying_type: :utc_datetime

    has_one :user_setting, Apps.Users.UserSetting
    has_one :subscription, Apps.Subscriptions.Subscription

    belongs_to :project, Apps.Projects.Project

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:device_id, :project_id, :product_expires_at])
    |> validate_required([:device_id, :project_id])
    |> assoc_constraint(:project)
  end
end
