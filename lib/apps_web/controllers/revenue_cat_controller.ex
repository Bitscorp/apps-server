defmodule AppsWeb.RevenueCatController do
  use AppsWeb, :controller

  require Logger

  @error_unprocessable_entity "ERROR_UNPROCESSABLE_ENTITY"

  def webhook(conn, %{"event" => event}) do
    case event do
      %{"app_user_id" => app_user_id} ->
        with {:ok, revenue_cat_event} <-
               Apps.RevenueCats.create_revenue_cat_event(%{
                 "event" => event,
                 "user_id" => app_user_id
               }),
             {:ok, _subscription} <-
               Apps.Subscriptions.upsert_subscription(
                 revenue_cat_event,
                 %{
                   "user_id" => app_user_id,
                   "product_id" => revenue_cat_event.event.product_id,
                   "expires_at" => revenue_cat_event.event.expiration_at_ms
               }) do
          conn
          |> put_status(:ok)
          |> render(:webhook, %{revenue_cat_event: revenue_cat_event})
        else
          err ->
            Logger.error("Error processing revenue cat webhook: #{inspect(err)}")

            conn
            |> put_status(:unprocessable_entity)
            |> json(%{
              error: %{
                message: @error_unprocessable_entity
              }
            })
        end

      _ ->
        conn
        |> put_status(:bad_request)
        |> json(%{errors: "Invalid event"})
    end
  end
end
