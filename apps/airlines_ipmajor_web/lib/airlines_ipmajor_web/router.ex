defmodule AirlinesIpmajorWeb.Router do
  use AirlinesIpmajorWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {AirlinesIpmajorWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug AirlinesIpmajorWeb.Plugs.Locale
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug AirlinesIpmajorWeb.Pipeline
  end

  pipeline :auth_api do
    plug AirlinesIpmajorWeb.Plugs.ApiAuthorizationPlug
  end

  pipeline :auth_api_admin do
    plug AirlinesIpmajorWeb.Plugs.ApiAuthorizationPlug, ["Admin"]
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :allowed_for_users do
    plug AirlinesIpmajorWeb.Plugs.AuthorizationPlug, ["Admin", "User"]
  end

  pipeline :allowed_for_admins do
    plug AirlinesIpmajorWeb.Plugs.AuthorizationPlug, ["Admin"]
  end

  scope "/", AirlinesIpmajorWeb do
    pipe_through [:browser, :auth]

    get "/", PageController, :index
    get "/login", SessionController, :new
    post "/login", SessionController, :login
    get "/logout", SessionController, :logout
    get "/register", UserController, :register
    post "/register", UserController, :register_create
    resources "/flights", FlightController, only: [:show]
    get "/upcoming-flights", FlightController, :upcoming
    get "/show-upcoming/:id", FlightController, :show_upcoming
  end

  scope "/", AirlinesIpmajorWeb do
    pipe_through [:browser, :auth, :ensure_auth, :allowed_for_users]

    get "/user", PageController, :user_index
    resources "/users", UserController, only: [:show, :delete]
    get "/edit-registration", UserController, :edit_registration
    put "/edit-registration", UserController, :update_registration
    get "/purchase-ticket/:id", FlightController, :purchase_ticket
    post "/confirm-purchase", FlightController, :confirm_purchase
    get "/generate-api-key", UserController, :generate_api_key
  end

  scope "/admin", AirlinesIpmajorWeb do
    pipe_through [:browser, :auth, :ensure_auth, :allowed_for_admins]

    resources "/users", UserController
    resources "/flights", FlightController
    get "/", PageController, :admin_index
  end

  scope "/api", AirlinesIpmajorWeb do
    pipe_through [:api]

    get "/flights", AirlinesRestController, :flights
    get "/flights/:id", AirlinesRestController, :flight
    get "airports", AirlinesRestController, :airports
    get "airports/:id", AirlinesRestController, :airport
    get "cities", AirlinesRestController, :cities
    get "cities/:id", AirlinesRestController, :city
    get "countries", AirlinesRestController, :countries
    get "countries/:id", AirlinesRestController, :country
  end

  scope "/api", AirlinesIpmajorWeb do
    pipe_through [:auth_api, :api]

    get "/user-tickets", AirlinesRestController, :user_tickets
    get "/secret", AirlinesRestController, :secret
  end

  scope "/api", AirlinesIpmajorWeb do
    pipe_through [:auth_api_admin, :api]

    get "/users", AirlinesRestController, :users
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: AirlinesIpmajorWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
