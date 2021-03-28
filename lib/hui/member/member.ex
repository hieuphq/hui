defmodule Hui.Member do
  import Ecto.Query

  alias Hui.Schema.UserHui
  alias Hui.Repo

  @active_status ["active"]

  def member?(hui_id, user_id) do
    query =
      from uh in UserHui,
        where: uh.hui_id == ^hui_id and uh.user_id == ^user_id and uh.status in ^@active_status

    query
    |> Repo.one()
    |> case do
      nil -> false
      _ -> true
    end
  end

  def owner?(hui_id, user_id) do
    query =
      from uh in UserHui,
        where:
          uh.hui_id == ^hui_id and uh.user_id == ^user_id and uh.status in ^@active_status and
            uh.is_owner == ^true

    query
    |> Repo.one()
    |> case do
      nil -> false
      _ -> true
    end
  end
end
