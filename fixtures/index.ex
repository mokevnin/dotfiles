defmodule ExtEnum do
  def key_by(enumerable, keyword) do
    enumerable
    |> Enum.reduce(%{}, fn element, acc ->
      Map.put(acc, Map.get(element, keyword), element)
    end)
  end
end
