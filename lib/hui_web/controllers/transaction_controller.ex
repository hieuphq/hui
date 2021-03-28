defmodule HuiWeb.TransactionController do
  use HuiWeb, :controller

  alias Hui.Transaction.TransactionDeposit
  alias Hui.HuiManagement
  alias Hui.Member

  action_fallback(HuiWeb.FallbackController)

  def self_deposit(conn, %{"hui_id" => hui_id} = params) do
    with user = %{} <- Guardian.Plug.current_resource(conn),
         true <- Member.member?(hui_id, user.id),
         hui = %{} <- HuiManagement.get(hui_id),
         {:ok, deposited} <- TransactionDeposit.create(user.id, hui, user.id, params) do
      conn
      |> put_status(201)
      |> render("deposit.json", transaction: deposited)
    else
      false ->
        {:error, :bad_request, :invalid_hui}

      nil ->
        {:error, :unauthorize, :invalid_token}

      errs ->
        errs
    end
  end

  def member_deposit(conn, %{"hui_id" => hui_id, "member_id" => member_id} = params) do
    with user = %{} <- Guardian.Plug.current_resource(conn),
         true <- Member.owner?(hui_id, user.id),
         {:member, true} <- {:member, Member.member?(hui_id, member_id)},
         hui = %{} <- HuiManagement.get(hui_id),
         {:ok, deposited} <- TransactionDeposit.create(user.id, hui, member_id, params) do
      conn
      |> put_status(201)
      |> render("deposit.json", transaction: deposited)
    else
      false ->
        {:error, :bad_request, :need_owner_permission}

      {:member, false} ->
        {:error, :bad_request, :invalid_member}

      nil ->
        {:error, :unauthorize, :invalid_token}

      errs ->
        errs
    end
  end
end
