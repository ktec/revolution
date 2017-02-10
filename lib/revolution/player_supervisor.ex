defmodule Revolution.PlayerSupervisor do
  alias Revolution.Player

  def start_link do
    import Supervisor.Spec, warn: false
    children = [
      worker(Player, [], [restart: :transient])
    ]
    opts = [strategy: :simple_one_for_one, max_restart: 0, name: __MODULE__]
    Supervisor.start_link(children, opts)
  end

  def start(id) do
    Supervisor.start_child(__MODULE__, [[id]])
  end

  def stop(id) do
    pid = :global.whereis_name(id)
    Supervisor.terminate_child(__MODULE__, pid)
    # Player.stop(pid)
  end

  def get_all do
    Supervisor.which_children(__MODULE__)
    |> Enum.map(&inspect_state(&1))
  end

  defp inspect_state({_, pid, _, _}), do: Player.inspect(pid)
end
