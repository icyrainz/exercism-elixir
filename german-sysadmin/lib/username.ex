defmodule Username do
  @spec sanitize(list) :: list()
  def sanitize([]), do: []

  def sanitize([h | t]) do
    # ä becomes ae
    # ö becomes oe
    # ü becomes ue
    # ß becomes ss
    case h do
      h when ?a <= h and h <= ?z -> [h | sanitize(t)]
      ?_ -> [?_ | sanitize(t)]
      ?ä -> ~c"ae" ++ sanitize(t)
      ?ö -> ~c"oe" ++ sanitize(t)
      ?ü -> ~c"ue" ++ sanitize(t)
      ?ß -> ~c"ss" ++ sanitize(t)
      _ -> sanitize(t)
    end
  end
end
