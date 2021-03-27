defmodule Hui.HuiManagement.HuiList do
  import Ecto.Query
  alias Hui.Schema.User
  alias Hui.Schema.UserHui
  alias Hui.Schema.Hui, as: HuiModel
  alias Hui.Repo

  @active_statuses ["active", "awaiting"]

  def list(user = %User{}, params) do
    user
    |> list_query()
    |> Repo.paginate(params)
  end

  defp list_query(%{id: user_id} = _user) do
    from uh in UserHui,
      join: h in HuiModel,
      on: h.id == uh.hui_id,
      where: uh.user_id == ^user_id and uh.status in ^@active_statuses,
      select: %{
        id: h.id,
        name: h.name,
        currency_id: h.currency_id,
        status: uh.status,
        is_owner: uh.is_owner
      }
  end
end
