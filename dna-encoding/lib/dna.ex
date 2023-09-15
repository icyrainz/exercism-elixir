defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?\s -> 0
      ?A -> 1
      ?C -> 2
      ?G -> 4
      ?T -> 8
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0 -> ?\s
      1 -> ?A
      2 -> ?C
      4 -> ?G
      8 -> ?T
    end
  end

  def encode(dna), do: do_encode(dna, <<>>)

  defp do_encode([], acc), do: acc

  defp do_encode([first | rest], acc) do
    encoded_first = first |> encode_nucleotide
    do_encode(rest, <<acc::bitstring, encoded_first::size(4)>>)
  end

  def decode(dna), do: do_decode(dna, [])

  defp do_decode(<<>>, acc), do: acc

  defp do_decode(<<first::size(4), rest::bitstring>>, acc) do
    decoded_first = first |> decode_nucleotide()
    do_decode(rest, acc ++ [decoded_first])
  end
end
