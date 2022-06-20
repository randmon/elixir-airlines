defmodule AirlinesIpmajor.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      AirlinesIpmajor.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: AirlinesIpmajor.PubSub}
      # Start a worker by calling: AirlinesIpmajor.Worker.start_link(arg)
      # {AirlinesIpmajor.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: AirlinesIpmajor.Supervisor)
  end
end
