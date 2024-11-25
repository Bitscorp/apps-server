defmodule AppsWeb.HealthyController do
  use AppsWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> json(%{status: "healthy"})
  end
end
