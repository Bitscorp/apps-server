defmodule Apps.Projects.Project do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias Apps.Users.User

  @type t() :: Apps.Projects.Specs.ProjectSpec.t()

  schema "projects" do
    # We are going to use api key for authentication
    # of api requests
    field :name, :string
    field :api_key, :string
    field :platform, :string

    has_many :users, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:platform, :name, :api_key])
    |> validate_required([:platform, :name])
  end
end
