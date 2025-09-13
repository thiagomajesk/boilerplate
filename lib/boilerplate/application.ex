defmodule Boilerplate.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BoilerplateWeb.Telemetry,
      Boilerplate.Repo,
      {DNSCluster, query: Application.get_env(:boilerplate, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Boilerplate.PubSub},
      # Start a worker by calling: Boilerplate.Worker.start_link(arg)
      # {Boilerplate.Worker, arg},
      # Start to serve requests, typically the last entry
      BoilerplateWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Boilerplate.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BoilerplateWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
