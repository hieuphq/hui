defmodule Util.Pagination do
  alias Scrivener.Page

  def info(result = %Page{}) do
    %{
      entries: result.entries,
      meta: %{
        page_number: result.page_number,
        page_size: result.page_size,
        total_entries: result.total_entries,
        total_pages: result.total_pages
      }
    }
  end
end
