defmodule HuiWeb.AuthController do
  use HuiWeb, :controller

  alias Hui.Auth

  action_fallback(HuiWeb.FallbackController)

  def login(conn, params) do
    with {:ok, token, user} <- Auth.login(params) do
      render(conn, "login.json", token: token, user: user)
    end
  end

  def sign_up(conn, params) do
    with {:ok, user} <- Auth.sign_up(params) do
      conn
      |> put_status(201)
      |> render("sign-up.json", user: user)
    end
  end
end
