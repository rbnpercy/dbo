defmodule Dbo do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # worker(Dbo.DB, [])
    ]

    opts = [strategy: :one_for_one, name: Dbo.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
