defmodule Hui.Invitation.InvitationCreator do
  alias Hui.User
  alias Hui.Member
  alias Hui.Member.MemberCreator

  def create(hui_id, _user, %{"identity" => identity}) do
    identity
    |> User.get_by_identity()
    |> do_create(hui_id)
  end

  defp do_create(nil, _hui_id) do
    {:error, :bad_request, :user_not_found}
  end

  defp do_create(%{id: user_id}, hui_id) do
    with false <- Member.member?(hui_id, user_id) do
      MemberCreator.create_member(hui_id, user_id)
    else
      true ->
        {:error, :bad_request, :user_is_added}
    end
  end
end
