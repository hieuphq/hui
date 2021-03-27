defmodule HuiWeb.AuthView do
  use HuiWeb, :view
  alias HuiWeb.UserView

  def render("login.json", %{token: token, user: user}) do
    %{
      token: token,
      user: render_one(user, UserView, "user.json")
    }
  end

  def render("sign-up.json", %{user: user}) do
    %{
      user: render_one(user, UserView, "user.json")
    }
  end
end
