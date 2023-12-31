defmodule LibraryFees do
  @noon ~T[12:00:00]

  def datetime_from_string(string) do
    case NaiveDateTime.from_iso8601(string) do
      {:ok, result} -> result
      _ -> nil
    end
  end

  def before_noon?(datetime) do
    datetime
    |> NaiveDateTime.to_time()
    |> Time.before?(@noon)
  end

  def return_date(checkout_datetime) do
    add_days = if before_noon?(checkout_datetime), do: 28, else: 29

    checkout_datetime
    |> NaiveDateTime.add(add_days, :day)
    |> NaiveDateTime.to_date()
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime
    |> NaiveDateTime.to_date()
    |> Date.diff(planned_return_date)
    |> max(0)
  end

  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week()
    |> Kernel.==(1)
  end

  def calculate_late_fee(checkout, return, rate) do
    return_datetime = return |> datetime_from_string()

    checkout
    |> datetime_from_string()
    |> return_date()
    |> days_late(return_datetime)
    |> Kernel.*(rate * if(monday?(return_datetime), do: 0.5, else: 1))
    |> trunc()
  end
end
