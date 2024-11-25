defmodule Apps.Projects do
  @moduledoc """
  The Projects context.
  """

  import Ecto.Query, warn: false
  alias Apps.Repo

  alias Apps.Projects.Project

  def create_project(attrs) do
    %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end

  def get_project!(id) do
    Repo.get!(Project, id)
  end
end
