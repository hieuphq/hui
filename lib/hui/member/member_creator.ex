defmodule Hui.Member.MemberCreator do
  alias Hui.Schema.UserHui
  alias Hui.Repo

  def create_owner(hui = %{}, user = %{}) do
    params = user_hui_params(hui, user, false)

    %UserHui{}
    |> UserHui.changeset(params)
    |> Repo.insert()
  end

  def create_member(hui_id, user_id) do
    params = user_hui_params(hui_id, user_id, true)

    %UserHui{}
    |> UserHui.changeset(params)
    |> Repo.insert()
  end

  defp user_hui_params(%{id: hui_id} = hui, %{id: user_id} = user, is_member)
       when is_map(hui) and is_map(user) do
    user_hui_params(hui_id, user_id, is_member)
  end

  defp user_hui_params(hui_id, user_id, is_member) do
    %{
      hui_id: hui_id,
      user_id: user_id,
      is_owner: !is_member,
      status: "active"
    }
  end
end
