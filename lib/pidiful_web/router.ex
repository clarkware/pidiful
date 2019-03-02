defmodule PidifulWeb.Router do
  use PidifulWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/api", Absinthe.Plug,
      schema: PidifulWeb.Schema.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: PidifulWeb.Schema.Schema,
      socket: PidifulWeb.UserSocket,
      interface: :simple
    end
end
