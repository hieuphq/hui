defmodule HuiWeb.HuiController do
  use HuiWeb, :controller

  alias Hui.HuiManagement.HuiCreator
  alias Hui.HuiManagement.HuiList
  alias Util.Pagination

  action_fallback(HuiWeb.FallbackController)

  def create(conn, params) do
    with user = %{} <- Guardian.Plug.current_resource(conn),
         {:ok, hui} <- HuiCreator.create(user, params) do
      render(conn, "show.json", hui: hui)
    else
      nil ->
        {:error, :unauthorize, :invalid_token}

      errs ->
        errs
    end
  end

  def index(conn, params) do
    with user = %{} <- Guardian.Plug.current_resource(conn) do
      huis =
        user
        |> HuiList.list(params)
        |> Pagination.info()

      render(conn, "index.json",
        hui: huis.entries,
        meta: huis.meta
      )
    else
      nil ->
        {:error, :unauthorize, :invalid_token}

      errs ->
        errs
    end
  end
end
