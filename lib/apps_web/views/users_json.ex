defmodule AppsWeb.DevicesJSON do
  def show(%{user: user}) do
    %{
      device_id: user.device_id
    }
  end
end
