defmodule HuiWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use HuiWeb, :controller

  alias HuiWeb.{ChangesetView, ErrorView}
  alias Plug.Conn.Status

  def call(conn, {:error, status, %Ecto.Changeset{} = changeset})
      when is_atom(status) do
    conn
    |> put_status(status)
    |> put_view(ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render(:"400")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(ErrorView)
    |> render(:"401")
  end

  def call(conn, {:error, status_code, reason}) when is_atom(status_code) and is_atom(reason) do
    status_number =
      status_code
      |> Status.code()

    msg =
      reason
      |> Atom.to_string()
      |> String.replace("_", " ")

    conn
    |> put_status(status_code)
    |> put_view(ErrorView)
    |> render(:"#{status_number}", code: reason, message: msg)
  end

  # This is called when no JWT token is present
  def auth_error(conn, {:unauthenticated, _reason}, _opts) do
    conn
    |> put_status(:unauthorized)
    |> put_view(ErrorView)
    |> render(:"401")
  end

  # In all other cases, we reply with 403
  def auth_error(conn, _reason, _opts) do
    conn
    |> put_status(:forbidden)
    |> put_view(ErrorView)
    |> render(:"403")
  end
end
