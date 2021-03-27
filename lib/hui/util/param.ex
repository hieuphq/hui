defmodule Hui.Util.Param do
  def remove_empty_string(attrs = %{}, field) do
    case Map.get(attrs, field, nil) do
      nil ->
        Map.pop(attrs, field)

      "" ->
        Map.pop(attrs, field)

      _val ->
        attrs
    end
  end
end
