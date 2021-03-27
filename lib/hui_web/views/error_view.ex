defmodule HuiWeb.ErrorView do
  use HuiWeb, :view

  def render("401.json", _assigns) do
    %{message: "Unauthorized"}
  end

  def render("403.json", _assigns) do
    %{message: "Forbidden"}
  end

  def template_not_found(_template, %{code: code, message: message}) do
    %{code: code, message: message}
  end

  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
