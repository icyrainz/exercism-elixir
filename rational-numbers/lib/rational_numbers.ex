defmodule RationalNumbers do
  @type rational :: {integer, integer}

  defp gcd(a, 0), do: a
  defp gcd(a, b), do: gcd(b, a |> rem(b))

  @doc """
  Add two rational numbers
  """
  @spec add(r1 :: rational, r2 :: rational) :: rational
  def add({a1, b1}, {a2, b2}) do
    reduce({a1 * b2 + a2 * b1, b1 * b2})
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a1, b1}, {a2, b2}) do
    reduce({a1 * b2 - a2 * b1, b1 * b2})
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a1, b1}, {a2, b2}) do
    reduce({a1 * a2, b1 * b2})
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a1, a2}, {b1, b2}) do
    reduce({a1 * b2, a2 * b1})
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(r :: rational) :: rational
  def abs({a, b}) do
    reduce({a |> Kernel.abs(), b |> Kernel.abs()})
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({a1, b1}, n) when n > 0, do: reduce({a1 ** n, b1 ** n})
  def pow_rational({a1, b1}, n), do: reduce({b1 ** -n, a1 ** -n})

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, n) do
    {a, b} = reduce(n)
    x ** (a / b)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(r :: rational) :: rational
  def reduce({a, b}) do
    gcd = gcd(a |> Kernel.abs(), b |> Kernel.abs())
    new_a = a |> div(gcd)
    new_b = b |> div(gcd)

    if new_b < 0 do
      {-new_a, -new_b}
    else
      {new_a, new_b}
    end
  end
end
