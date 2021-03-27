defmodule Hui.Auth do
  alias Hui.Schema.User
  alias Hui.Repo
  alias Hui.User, as: UserRepo
  alias Hui.Guardian

  def sign_up(%{"identity" => identity} = params) do
    with type when type != :unknown <- identity_parse(identity) do
      params
      |> User.create_changeset(type)
      |> Repo.insert()
    else
      :unknown -> {:error, :bad_request, :invalid_identity}
      errs -> errs
    end
  end

  defp identity_parse(val) when is_binary(val) do
    cond do
      phone_valid?(val) == true -> :phone
      email_valid?(val) == true -> :email
      true -> :unknown
    end
  end

  defp phone_valid?(val) do
    case Phone.parse(val) do
      {:ok, _} -> true
      _ -> false
    end
  end

  defp email_valid?(val) do
    case Regex.run(~r/^[\w.!#$%&’*+\-\/=?\^`{|}~]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*$/i, val) do
      nil ->
        false

      [_email | _] ->
        true
    end
  end

  def login(%{"identity" => identity, "password" => password} = _params) do
    with user = %{} <- UserRepo.get_by_identity(identity),
         {:check_password, true} <- {:check_password, validate_password(user, password)},
         {:ok, token, _claims} = Guardian.encode_and_sign(user) do
      {:ok, token, user}
    else
      nil ->
        {:error, :not_found, "account or password is invalid"}

      {:check_password, _} ->
        {:error, :not_found, "account or password is invalid"}

      errs ->
        errs
    end
  end

  defp validate_password(%{hashed_password: hashed_password}, password) do
    Bcrypt.verify_pass(password, hashed_password)
  end
end
