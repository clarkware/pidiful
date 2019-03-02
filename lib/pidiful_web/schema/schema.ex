defmodule PidifulWeb.Schema.Schema do
  use Absinthe.Schema

  alias PidifulWeb.Resolvers
  alias PidifulWeb.Schema.Middleware

  query do
    @desc "List all the currently-running processes"
    field :processes, list_of(:process) do
      resolve &Resolvers.Processes.processes/3
    end
  end

  object :process do
    field :pid, non_null(:string) do
      resolve fn parent, _, _ ->
        {:ok, parent}
      end
    end
    field :status, non_null(:string) 
    field :registered_name, :string
    field :message_queue_len, non_null(:integer)
    field :heap_size, non_null(:integer)
    field :stack_size, non_null(:integer)
    field :reductions, non_null(:integer)
    field :messages, list_of(:string)
    field :links, list_of(:process) do
      resolve &Resolvers.Processes.links/3
    end
  end

  def middleware(middleware, field, %{identifier: :process} = object) do  
    new_middleware = {Middleware.ProcessInfo, field.identifier} 
      
    middleware
      |> Absinthe.Schema.replace_default(new_middleware, field, object)
  end

  def middleware(middleware, _field, _object) do
    middleware
  end
end
