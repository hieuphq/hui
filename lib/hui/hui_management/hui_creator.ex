defmodule Hui.HuiManagement.HuiCreator do
  alias Hui.Currency
  alias Hui.Schema.Hui, as: HuiModel
  alias Hui.Schema.User
  alias Hui.Schema.UserHui
  alias Hui.Repo

  def create(user = %User{}, params) do
    with %{id: currency_id} <- Currency.get_by_code(),
         params <- Map.put(params, "currency_id", currency_id),
         {:ok, created} <- create_hui(params),
         {:ok, _connection} <- create_user_hui(created, user, true) do
      {:ok, created}
    else
      nil -> {:error, :bad_request, :currency_is_missing}
    end
  end

  defp create_hui(params) do
    %HuiModel{}
    |> HuiModel.create_changeset(params)
    |> Repo.insert()
  end

  defp create_user_hui(hui, user, is_owner) do
    params =
      hui
      |> user_hui_params(user, is_owner)

    %UserHui{}
    |> UserHui.changeset(params)
    |> Repo.insert()
  end

  defp user_hui_params(%{id: hui_id} = _hui, %{id: user_id} = _user, true = is_owner) do
    %{
      hui_id: hui_id,
      user_id: user_id,
      is_owner: is_owner,
      status: "active"
    }
  end

  defp user_hui_params(%{id: hui_id} = _hui, %{id: user_id} = _user, false = is_owner) do
    %{
      hui_id: hui_id,
      user_id: user_id,
      is_owner: is_owner,
      status: "awaiting"
    }
  end
end
