defmodule HuiWeb.UserController do
  use HuiWeb, :controller

  alias Hui.User

  action_fallback(HuiWeb.FallbackController)

  def me(conn, _) do
    with user = %{} <- Guardian.Plug.current_resource(conn) do
      render(conn, "show.json", user: user)
    else
      nil ->
        {:error, :unauthorize, :invalid_token}
    end
  end

  def update_me(conn, params) do
    with user = %{} <- Guardian.Plug.current_resource(conn),
         {:ok, updated} <- User.update_me(user, params) do
      render(conn, "show.json", user: updated)
    else
      nil ->
        {:error, :unauthorize, :invalid_token}
    end
  end
end
