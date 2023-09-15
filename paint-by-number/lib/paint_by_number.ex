defmodule PaintByNumber do
  def palette_bit_size(color_count) when color_count == 0, do: 0
  def palette_bit_size(color_count) when color_count <= 2, do: 1
  def palette_bit_size(color_count) do
    1 + palette_bit_size(color_count / 2)
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0b00::2, 0b01::2, 0b10::2, 0b11::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    pallete_size = palette_bit_size(color_count)
    <<pixel_color_index::size(pallete_size) , picture::bitstring>>
  end

  def get_first_pixel(<<>>, _), do: nil
  def get_first_pixel(picture, color_count) do
    pallete_size = palette_bit_size(color_count)
    <<first_pixel::size(pallete_size), _::bitstring>> = picture
    first_pixel
  end

  def drop_first_pixel(<<>>, _), do: <<>>
  def drop_first_pixel(picture, color_count) do
    pallete_size = palette_bit_size(color_count)
    <<_::size(pallete_size), rest::bitstring>> = picture
    rest
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
