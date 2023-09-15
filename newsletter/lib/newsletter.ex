defmodule Newsletter do
  def read_emails(path) do
    path |> File.read!() |> String.split()
  end

  def open_log(path) do
    path |> File.open!([:write])
  end

  def log_sent_email(pid, email) do
    pid |> IO.puts(email)
  end

  def close_log(pid) do
    pid |> File.close()
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    file = log_path |> open_log()

    emails_path
    |> read_emails()
    |> Enum.each(fn email ->
      case send_fun.(email) do
        :ok ->
          file |> log_sent_email(email)

        _ ->
          nil
      end
    end)

    file |> close_log()
  end
end
