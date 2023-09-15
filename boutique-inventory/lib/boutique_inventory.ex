defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    inventory |> Enum.sort_by(& &1.price, :asc)
  end

  def with_missing_price(inventory) do
    inventory |> Enum.filter(&(&1.price == nil))
  end

  def update_names(inventory, old_word, new_word) do
    inventory
    |> Enum.map(fn item ->
      item
      |> Map.update(
        :name,
        nil,
        fn name ->
          name
          |> String.replace(old_word, new_word)
        end
      )
    end)
  end

  def increase_quantity(item, count) do
    item
    |> Map.update(
      :quantity_by_size,
      nil,
      fn size_map ->
        size_map |> Map.new(fn {size, cur_count} -> {size, cur_count + count} end)
      end
    )
  end

  def total_quantity(item) do
    item.quantity_by_size |> Enum.reduce(0, fn {_, count}, acc -> acc + count end)
  end
end
