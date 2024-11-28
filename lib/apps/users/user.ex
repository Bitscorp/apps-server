defmodule Apps.Users.User do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @type t() :: Specs.UserSpec.t()

  schema "users" do
    field :device_id, :string

    has_one :user_setting, Apps.Users.UserSetting

    belongs_to :project, Apps.Projects.Project

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:device_id, :project_id])
    |> validate_required([:device_id, :project_id])
    |> assoc_constraint(:project)
  end
end
