defmodule ExAthena.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    oban = Application.get_env(:exathena, Oban)

    children =
      [
        ExAthena.Repo,
        ExAthenaWeb.Telemetry,
        {Phoenix.PubSub, name: ExAthena.PubSub},
        ExAthenaWeb.Endpoint,
        ExAthena.Vault,
        {Oban, oban},
      ] ++
        start_configs() ++
        start_databases() ++

    opts = [strategy: :one_for_one, name: ExAthena.Supervisor]
    Supervisor.start_link(children, opts)
  end

  if Mix.env() == :test do
    defp start_databases(), do: []
    defp start_configs(), do: []
  else
    defp start_configs() do
      [ExAthena.Config]
    end

    defp start_databases() do
      [ExAthena.Database]
    end

  end

  @impl true
  def config_change(changed, _new, removed) do
    ExAthenaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
