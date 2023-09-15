defmodule WineCellar do
  @wine_white "Fermented without skin contact."
  @wine_red "Fermented with skin contact using dark-colored grapes."
  @wine_rose "Fermented with some skin contact, but not enough to qualify as a red wine."

  def explain_colors do
    [
      {:white, @wine_white},
      {:red, @wine_red},
      {:rose, @wine_rose}
    ]
  end

  @type wine :: {name :: String.t(), year :: non_neg_integer(), country :: String.t()}

  @spec filter(cellar :: list(wine), color :: String.t(), opts :: list) :: list(wine)
  def filter(cellar, color, opts \\ [])
  def filter([], _, _), do: []

  def filter(cellar, color, opts) do
    cellar
    |> Keyword.get_values(color)
    |> filter_by_year(opts[:year])
    |> filter_by_country(opts[:country])
  end

  defp filter_by_year(wines, nil), do: wines
  defp filter_by_country(wines, nil), do: wines

  # The functions below do not need to be modified.

  defp filter_by_year(wines, year)
  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end
