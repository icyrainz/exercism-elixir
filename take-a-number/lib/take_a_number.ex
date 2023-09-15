defmodule TakeANumber do
  @initial_ticket 0

  @spec start() :: pid()
  def start() do
    spawn(fn -> receive_loop(@initial_ticket) end)
  end

  defp receive_loop(last_ticket) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, last_ticket)
        receive_loop(last_ticket)

      {:take_a_number, sender_pid} ->
        new_ticket = last_ticket + 1
        send(sender_pid, new_ticket)
        receive_loop(new_ticket)

      :stop ->
        nil

      _ ->
        receive_loop(last_ticket)
    end
  end
end
