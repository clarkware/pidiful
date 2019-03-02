defmodule PidifulWeb.Schema.Middleware.ProcessInfo do
  @moduledoc """
  Assumes the object it receives is a PID and uses `:erlang.process_info` to get the value for this field. If this field is already marked as resolved, then this middleware does not touch it.
  """

  @behaviour Absinthe.Middleware

  alias PidifulWeb.Schema.Utils

  def call(%{state: :unresolved, source: source} = res, key) do
    info_tuple =
      source 
      |> Utils.pid_from_string
      |> :erlang.process_info(key)

    value =
      case info_tuple do
        {^key, value} ->
          value
        [] ->
          nil
        end

    %{res | state: :resolved, value: value}
  end

  def call(res, _key), do: res
end
