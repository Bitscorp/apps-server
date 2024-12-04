defmodule AppsWeb.Plugs.ApiKeyAuth do
  @moduledoc """
  API key authentication plug by projects.
  """
  import Plug.Conn
  import Phoenix.Controller

  alias Apps.Projects

  require Logger

  @error_missing_api_key "ERROR_MISSING_API_KEY"
  @error_invalid_api_key "ERROR_INVALID_API_KEY"
  @error_project_mismatch "ERROR_PROJECT_MISMATCH"

  def init(opts), do: opts

  def call(conn, _opts) do
    with {:ok, api_key} <- get_api_key(conn),
         {:ok, project} <- get_project(api_key),
         {:ok, _project_id} <- validate_project_id(conn, project) do
      conn
      |> assign(:current_project, project)
    else
      {:error, :missing_api_key} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: @error_missing_api_key})
        |> halt()

      {:error, :invalid_api_key} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: @error_invalid_api_key})
        |> halt()

      {:error, :project_mismatch} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: @error_project_mismatch})
        |> halt()
    end
  end

  defp get_api_key(conn) do
    case get_req_header(conn, "x-api-key") do
      [api_key | _] -> {:ok, api_key}
      [] -> {:error, :missing_api_key}
    end
  end

  defp get_project(api_key) do
    case Projects.get_project_by_api_key(api_key) do
      nil -> {:error, :invalid_api_key}
      project -> {:ok, project}
    end
  end

  defp validate_project_id(conn, project) do
    case conn.params["project_id"] do
      nil -> {:ok, project.id}
      id -> if to_string(project.id) == id, do: {:ok, project.id}, else: {:error, :project_mismatch}
    end
  end
end
