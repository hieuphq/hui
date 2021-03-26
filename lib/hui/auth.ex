defmodule Hui.Auth do
  alias Hui.Schema.User
  alias Hui.Repo
  alias Hui.User, as: UserRepo
  alias Hui.Guardian

  def sign_up(params) do
    params
    |> User.create_changeset()
    |> Repo.insert()
  end

  def login(%{"email" => email, "password" => password} = _params) do
    with user = %{} <- UserRepo.get_by_email(email),
         {:check_password, true} <- {:check_password, validate_password(user, password)},
         {:ok, token, _claims} = Guardian.encode_and_sign(user) do
      {:ok, token, user}
    else
      nil ->
        {:error, :not_found, "email or password is invalid"}

      {:check_password, _} ->
        {:error, :not_found, "email or password is invalid"}

      errs ->
        errs
    end
  end

  defp validate_password(%{hashed_password: hashed_password}, password) do
    Bcrypt.verify_pass(password, hashed_password)
  end
end
