defmodule LanguageList do
  def new() do
    []
  end

  def add(list, language) do
    [language | list]
  end

  def remove([_ | rest]) do
    rest
  end

  def first([first | _]) do
    first
  end

  def count(list) do
    list |> length
  end

  def functional_list?(list) do
    "Elixir" in list
  end
end
