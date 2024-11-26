defmodule AppsWeb.RevenueCatJSON do
  def webhook(%{revenue_cat_event: revenue_cat_event}) do
    %{
      user_id: revenue_cat_event.user_id
    }
  end
end
