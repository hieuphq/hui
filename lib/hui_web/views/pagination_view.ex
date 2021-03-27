defmodule HuiWeb.PaginationView do
  use HuiWeb, :view

  def render("show.json", %{pagination: meta}) do
    %{
      page_number: meta.page_number,
      page_size: meta.page_size,
      total_pages: meta.total_pages,
      total_entries: meta.total_entries
    }
  end
end
