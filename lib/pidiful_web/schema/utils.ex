defmodule PidifulWeb.Schema.Utils do

  def pid_from_string(string) when is_binary(string) do
    string
    |> :erlang.binary_to_list
    |> :erlang.list_to_pid
  end

  def pid_to_string(pid) when is_pid(pid) do
    pid
    |> :erlang.pid_to_list()
    |> to_string()
  end
end