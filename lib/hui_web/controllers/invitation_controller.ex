defmodule HuiWeb.InvitationController do
  use HuiWeb, :controller

  alias Hui.Member
  alias Hui.Invitation.InvitationCreator

  action_fallback(HuiWeb.FallbackController)

  def create(conn, %{"hui_id" => hui_id} = params) do
    with user = %{} <- Guardian.Plug.current_resource(conn),
         true <- Member.member?(hui_id, user.id),
         {:ok, invitation} <- InvitationCreator.create(hui_id, user, params) do
      conn
      |> put_status(201)
      |> render("show.json", invitation: invitation)
    else
      false ->
        {:error, :bad_request, :invalid_hui}

      nil ->
        {:error, :unauthorize, :invalid_token}

      errs ->
        errs
    end
  end
end
