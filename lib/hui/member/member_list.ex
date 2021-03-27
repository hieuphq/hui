defmodule Hui.Member.MemberList do
  import Ecto.Query

  alias Hui.Schema.UserHui
  alias Hui.Schema.User
  alias Hui.Repo

  @active_status ["active"]

  def list_by_user_id(hui_id, params) do
    list_query(hui_id)
    |> Repo.paginate(params)
  end

  defp list_query(hui_id) do
    from uh in UserHui,
      join: u in User,
      on: uh.user_id == u.id,
      where: uh.hui_id == ^hui_id and uh.status in ^@active_status,
      select: %{
        id: uh.id,
        name: u.name,
        identity: u.identity,
        status: u.status,
        is_owner: uh.is_owner,
        user_id: u.id
      }
  end
end
