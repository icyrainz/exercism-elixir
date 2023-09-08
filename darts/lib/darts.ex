defmodule Darts do
  @type position :: {number, number}

  @inner_circle_radius_sq 1
  @middle_circle_radius_sq 5 * 5
  @outer_circle_radius_sq 10 * 10

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    distance = x * x + y * y
    case distance do
      d when d <= @inner_circle_radius_sq -> 10
      d when d <= @middle_circle_radius_sq -> 5
      d when d <= @outer_circle_radius_sq -> 1
      _ -> 0
    end
  end
end
