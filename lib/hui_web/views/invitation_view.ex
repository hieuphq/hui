defmodule HuiWeb.InvitationView do
  use HuiWeb, :view

  def render("show.json", %{invitation: invitation}) do
    render_one(invitation, __MODULE__, "invitation.json")
  end

  def render("invitation.json", %{invitation: invitation}) do
    %{
      id: invitation.id,
      user_id: invitation.user_id,
      hui_id: invitation.hui_id,
      is_owner: invitation.is_owner,
      status: invitation.status
    }
  end
end
