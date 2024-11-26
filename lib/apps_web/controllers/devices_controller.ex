defmodule AppsWeb.DevicesController do
  alias Apps.Users
  use AppsWeb, :controller

  def upsert(conn, %{"project_id" => project_id, "device_id" => device_id}) do
    case Users.upsert_user(%{project_id: project_id, device_id: device_id}) do
      {:ok, user} ->
        conn
        |> put_status(:ok)
        |> render(:show, %{user: user})

      {:error, _} ->
        conn
        |> put_status(:internal_server_error)
        |> json(%{status: "error"})
    end
  end
end
