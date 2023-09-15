defmodule FileSniffer do
  @data [
    %{
      :extension => "exe",
      :media_type => "application/octet-stream",
      :binary_sig => [0x7F, 0x45, 0x4C, 0x46]
    },
    %{
      :extension => "bmp",
      :media_type => "image/bmp",
      :binary_sig => [0x42, 0x4D]
    },
    %{
      :extension => "png",
      :media_type => "image/png",
      :binary_sig => [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]
    },
    %{
      :extension => "jpg",
      :media_type => "image/jpg",
      :binary_sig => [0xFF, 0xD8, 0xFF]
    },
    %{
      :extension => "gif",
      :media_type => "image/gif",
      :binary_sig => [0x47, 0x49, 0x46]
    }
  ]

  def type_from_extension(extension) do
    @data
    |> Enum.filter(&(&1.extension == extension))
    |> Enum.map(& &1.media_type)
    |> Enum.at(0)
  end

  def type_from_binary(file_binary) do
    @data
    |> Enum.filter(fn item ->
      case file_binary do
        <<first::binary-size(item.binary_sig |> length), _::binary>> ->
          :binary.bin_to_list(first) == item.binary_sig

        _ ->
          false
      end
    end)
    |> Enum.map(& &1.media_type)
    |> Enum.at(0)
  end

  def verify(file_binary, extension) do
    bin_type = type_from_binary(file_binary)

    case type_from_extension(extension) do
      ^bin_type when bin_type != nil -> {:ok, bin_type}
      _ -> {:error, "Warning, file format and file extension do not match."}
    end
  end
end
