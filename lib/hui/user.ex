defmodule Hui.User do
  alias Hui.Schema.User
  alias Hui.Repo

  def get_by_email(email) when is_binary(email) do
    Repo.get_by(User, email: email)
  end

  def get_by_id(id) do
    Repo.get(User, id)
  end
end
