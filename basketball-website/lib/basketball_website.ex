defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    extract_from_pathlist(data, path |> String.split("."))
  end

  defp extract_from_pathlist(nil, _), do: nil
  defp extract_from_pathlist(data, []), do: data

  defp extract_from_pathlist(data, [first | rest]) do
    extract_from_pathlist(data[first], rest)
  end

  def get_in_path(data, path) do
    data |> get_in(path |> String.split("."))
  end
end
