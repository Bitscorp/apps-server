defmodule Apps.Repo do
  use Ecto.Repo,
    otp_app: :apps,
    adapter: Ecto.Adapters.Postgres
end
