defmodule Apps.RevenueCats do
  @moduledoc false

  import Ecto.Query, warn: false
  alias Apps.Repo

  alias Apps.RevenueCats.RevenueCatEvent

  @doc """
  Creates a revenue_cat_event.

  ## Examples

      iex> create_revenue_cat_event(%{field: value})
      {:ok, %RevenueCatEvent{}}

      iex> create_revenue_cat_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_revenue_cat_event(attrs \\ %{}) do
    %RevenueCatEvent{}
    |> RevenueCatEvent.changeset(attrs)
    |> Repo.insert()
  end
end
