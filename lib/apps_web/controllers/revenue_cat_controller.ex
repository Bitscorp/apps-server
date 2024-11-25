defmodule AppsWeb.RevenueCatController do
  use AppsWeb, :controller

  def show(conn, _params) do
    conn
    |> put_status(:ok)
    |> json(%{status: "healthy"})
  end
end
