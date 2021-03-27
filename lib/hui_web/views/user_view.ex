defmodule HuiWeb.UserView do
  use HuiWeb, :view

  def render("show.json", %{user: user}) do
    render_one(user, __MODULE__, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{
      identity: parse_identity(user),
      name: user.name
    }
  end

  defp parse_identity(%{identity_type: "email", email: email}), do: email
  defp parse_identity(%{identity_type: "phone", phone: phone}), do: phone
  defp parse_identity(_), do: ""
end
