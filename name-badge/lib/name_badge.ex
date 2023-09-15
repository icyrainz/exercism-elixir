defmodule NameBadge do
  @spec print(id :: non_neg_integer() | nil, name :: String.t(), department :: String.t()) :: String.t()
  def print(id, name, department) do
    department = if department, do: department |> String.upcase, else: "OWNER"
    if id do
      "[#{id}] - #{name} - #{department}"
    else
      "#{name} - #{department}"
    end
  end
end
