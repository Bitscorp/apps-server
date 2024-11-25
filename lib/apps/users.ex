defmodule Apps.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Apps.Repo

  alias Apps.Users.User
  alias Apps.Users.UserSetting

  def upsert_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert(
      on_conflict: {:replace, [:device_id]},
      conflict_target: [:device_id, :project_id]
    )
  end

  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def create_user_setting(attrs) do
    %UserSetting{}
    |> UserSetting.changeset(attrs)
    |> Repo.insert()
  end

  def upsert_settings(attrs) do
    %UserSetting{}
    |> UserSetting.changeset(attrs)
    |> Repo.insert(on_conflict: {:replace, [:settings]}, conflict_target: [:user_id])
  end
end
