defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ApiWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug
  end

  scope "/", ApiWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", ApiWeb do
    pipe_through :api

    # USERS ROUTES

    resources "/users", UserController, except: [:new, :edit], param: "userID"

    # get("/users", UserController, :showBy)
    # get("/users/:userID", UserController, :show)
    # post("/users", UserController, :create)
    # put("/users/:userID", UserController, :update)
    # delete("/users/:userID", UserController, :delete)

   # WORKINGTIMES ROUTES

    get("/workingtimes/:userID", WorkingtimeController, :showByUser)
    get("/workingtimes/:userID/:id", WorkingtimeController, :show)
    put("/workingtimes/:id", WorkingtimeController, :update)
    delete("/workingtimes/:id", WorkingtimeController, :delete)

    resources "/workingtimes", WorkingtimeController, except: [:new, :edit], param: "userID"
    post("/workingtimes/:userID", WorkingtimeController, :create)

   # CLOCKS ROUTES

    get("/clocks/:userID", ClockController, :show)
    post("/clocks/:userID", ClockController, :create)

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

      live_dashboard "/dashboard", metrics: ApiWeb.Telemetry
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
