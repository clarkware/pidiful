# Pidiful

A super-simple GraphQL API for exploring processes in an Erlang VM, mainly 
just as a quick demonstration that GraphQL isn't just for querying databases.

Powered by [Absinthe](https://github.com/absinthe-graphql/absinthe) (the GraphQL toolkit for Elixir) running in a [Phoenix](https://phoenixframework.org/) server.

## Installation

1. Install dependencies:

    ```sh
    mix deps.get
    ```

2. Fire up the Phoenix endpoint:

    ```sh
    mix phx.server
    ```

3. Visit [`localhost:4000/graphiql`](http://localhost:4000/graphiql) to explore the GraphQL API using the GraphiQL user interface.

## Example Query

```graphql
query {
  processes {
    pid
    status
    registeredName
    heapSize
    stackSize
    reductions
    messageQueueLen
    messages
    links {
      pid
      status
    }
  }
}
```
