defmodule HuiWeb.Router do
  use HuiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt do
    plug(Hui.AuthAccessPipeline)
  end

  forward("/healthz", HealthCheckup, resp_body: "ok")

  scope "/api", HuiWeb do
    pipe_through :api

    scope "/auth" do
      post("/login", AuthController, :login)
      post("/sign-up", AuthController, :sign_up)
    end
  end

  scope "/api", HuiWeb do
    pipe_through([:api, :jwt])

    get("/me", UserController, :me)
    put("/me", UserController, :update_me)
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
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: HuiWeb.Telemetry
    end
  end
end
