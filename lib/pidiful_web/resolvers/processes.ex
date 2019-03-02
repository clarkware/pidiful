defmodule PidifulWeb.Resolvers.Processes do

  alias PidifulWeb.Schema.Utils

  def processes(_, _, _) do
    pids = 
      Process.list 
      |> Enum.map(&Utils.pid_to_string/1)
    {:ok, pids}
  end

  def links(parent, _, _) do
    {:links, links} = 
      parent 
      |> Utils.pid_from_string
      |> :erlang.process_info(:links)

    pids =
      links 
      |> Enum.filter(&is_pid/1)
      |> Enum.map(&Utils.pid_to_string/1)
      
    {:ok, pids}
  end
end
