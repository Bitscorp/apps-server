defmodule AppsWeb.Router do
  use AppsWeb, :router

  import LiveAdmin.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {AppsWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_auth do
    plug AppsWeb.Plugs.ApiKeyAuth
  end

  pipeline :http_basic_protected do
    import Plug.BasicAuth

    plug :basic_auth, Application.compile_env(:apps, :basic_auth)
  end

  scope "/", AppsWeb do
    pipe_through :api

    get "/healthy", HealthyController, :index

    scope "/projects/:project_id" do
      pipe_through :api_auth

      scope "/devices/:device_id" do
        post "/", DevicesController, :upsert
        post "/settings", SettingsController, :upsert
      end
    end

    scope "/projects/:project_id" do
      post "/revenue_cat/webhook", RevenueCatController, :webhook
    end
  end

  scope "/", AppsWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/", AppsWeb do
    pipe_through [:browser, :http_basic_protected]

    live_admin "/admin" do
      admin_resource("/users", Apps.Admin.Users)
      admin_resource("/projects", Apps.Admin.Projects)
      admin_resource("/revenue_cat_events", Apps.Admin.RevenueCatEvents)
      admin_resource("/subscriptions", Apps.Admin.Subscriptions)
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", AppsWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:apps, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: AppsWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
