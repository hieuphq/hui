defmodule Hui.HuiManagement.HuiCreator do
  alias Hui.Currency
  alias Hui.Schema.Hui, as: HuiModel
  alias Hui.Schema.User
  alias Hui.Member.MemberCreator
  alias Hui.Repo

  def create(user = %User{}, params) do
    with %{id: currency_id} <- Currency.get_by_code(),
         params <- Map.put(params, "currency_id", currency_id),
         {:ok, created} <- create_hui(params),
         {:ok, _connection} <- MemberCreator.create_owner(created, user) do
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
end
