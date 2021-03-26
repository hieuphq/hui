defmodule HuiWeb.UserView do
  use HuiWeb, :view

  def render("show.json", %{user: user}) do
    render_one(user, __MODULE__, user)
  end

  def render("user.json", %{user: user}) do
    %{
      email: user.email,
      name: user.name
    }
  end
end
