defmodule Hui.User do
  alias Hui.Schema.User
  alias Hui.Repo
  alias Hui.Util.Param

  def get_by_identity(identity) when is_binary(identity) do
    Repo.get_by(User, identity: identity)
  end

  def get_by_id(id) do
    Repo.get(User, id)
  end

  def update_me(user, params) do
    params = Param.remove_empty_string(params, "password")

    user
    |> User.update_changeset(params)
    |> Repo.update()
  end
end
