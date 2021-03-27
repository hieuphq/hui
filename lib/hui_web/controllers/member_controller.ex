defmodule HuiWeb.MemberController do
  use HuiWeb, :controller

  alias Hui.Member
  alias Hui.Member.MemberList
  alias Util.Pagination

  action_fallback(HuiWeb.FallbackController)

  def index(conn, %{"hui_id" => hui_id} = params) do
    with user = %{} <- Guardian.Plug.current_resource(conn),
         true <- Member.member?(hui_id, user.id) do
      data =
        hui_id
        |> MemberList.list_by_user_id(params)
        |> Pagination.info()

      render(conn, "index.json", member: data.entries, meta: data.meta)
    else
      false ->
        {:error, :bad_request, :invalid_hui}

      nil ->
        {:error, :unauthorize, :invalid_token}
    end
  end
end
