defmodule Hui.User do
  alias Hui.Schema.User
  alias Hui.Repo

  def get_by_identity(identity) when is_binary(identity) do
    Repo.get_by(User, identity: identity)
  end

  def get_by_id(id) do
    Repo.get(User, id)
  end
end
