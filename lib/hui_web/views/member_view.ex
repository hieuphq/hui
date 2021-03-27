defmodule HuiWeb.MemberView do
  use HuiWeb, :view

  alias HuiWeb.PaginationView

  def render("index.json", %{member: member, meta: meta}) do
    %{
      data: render_many(member, __MODULE__, "member.json"),
      meta: render_one(meta, PaginationView, "show.json")
    }
  end

  def render("member.json", %{member: member}) do
    %{
      id: member.id,
      identity: member.identity,
      status: member.status,
      is_owner: member.is_owner,
      name: member.name,
      user_id: member.user_id
    }
  end
end
