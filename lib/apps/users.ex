defmodule Apps.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Apps.Repo

  alias Apps.Users.User

  def upsert_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert(on_conflict: {:replace, [:device_id]}, conflict_target: [:device_id])
  end

  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
