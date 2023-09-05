defmodule Lasagna do
  def expected_minutes_in_oven do
    40
  end

  def remaining_minutes_in_oven(current_minute) do
    expected_minutes_in_oven() - current_minute
  end

  def preparation_time_in_minutes(number_of_layers) do
    2 * number_of_layers
  end

  def total_time_in_minutes(number_of_layers, minutes_so_far) do
    preparation_time_in_minutes(number_of_layers) + minutes_so_far
  end

  def alarm do
    "Ding!"
  end
end
