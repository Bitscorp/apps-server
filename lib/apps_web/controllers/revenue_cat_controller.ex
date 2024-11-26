defmodule AppsWeb.RevenueCatController do
  use AppsWeb, :controller

  def webhook(conn, %{"event" => event}) do
    case event do
      %{"app_user_id" => app_user_id} ->
        case Apps.RevenueCats.create_revenue_cat_event(%{
               "event" => event,
               "user_id" => app_user_id
             }) do
          {:ok, revenue_cat_event} ->
            conn
            |> put_status(:ok)
            |> render(:webhook, %{revenue_cat_event: revenue_cat_event})

          {:error, changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> json(%{errors: changeset})
        end

      _ ->
        conn
        |> put_status(:bad_request)
        |> json(%{errors: "Invalid event"})
    end
  end
end
