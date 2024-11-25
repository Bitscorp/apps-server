defmodule Apps.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset

  alias Apps.Users.User

  @type t() :: Specs.ProjectSpec.t()

  schema "projects" do
    field :name, :string
    field :platform, :string

    has_many :users, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:platform, :name])
    |> validate_required([:platform, :name])
  end
end
