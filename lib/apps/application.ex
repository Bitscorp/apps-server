defmodule Apps.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AppsWeb.Telemetry,
      Apps.Repo,
      {DNSCluster, query: Application.get_env(:apps, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Apps.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Apps.Finch},
      # Start a worker by calling: Apps.Worker.start_link(arg)
      # {Apps.Worker, arg},
      # Start to serve requests, typically the last entry
      AppsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Apps.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AppsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
