defmodule HuiWeb.HuiView do
  use HuiWeb, :view

  alias HuiWeb.PaginationView

  def render("index.json", %{hui: hui, meta: meta}) do
    %{
      data: render_many(hui, __MODULE__, "hui-with-status.json"),
      meta: render_one(meta, PaginationView, "show.json")
    }
  end

  def render("show.json", %{hui: hui}) do
    render_one(hui, __MODULE__, "hui.json")
  end

  def render("hui.json", %{hui: hui}) do
    %{
      id: hui.id,
      name: hui.name
    }
  end

  def render("hui-with-status.json", %{hui: hui}) do
    %{
      id: hui.id,
      name: hui.name,
      status: hui.status,
      is_owner: hui.is_owner
    }
  end
end
