defmodule AppsWeb.SettingsController do
  use AppsWeb, :controller

  alias Apps.Users

  def upsert(conn, %{"project_id" => _project_id, "user_id" => user_id, "settings" => settings}) do
    case Users.upsert_settings(%{user_id: user_id, settings: settings}) do
      {:ok, user_setting} ->
        conn
        |> put_status(:ok)
        |> render(:upsert, %{user_setting: user_setting})

      {:error, _} ->
        conn
        |> put_status(:internal_server_error)
        |> json(%{status: "error"})
    end
  end
end
