defmodule Revolution.Game do
  use GenServer
  alias Revolution.{Endpoint, Player, PlayerSupervisor}

  def join(user_id) do
    PlayerSupervisor.start(user_id)
    sprites = PlayerSupervisor.get_all
    {:ok, %{id: user_id, sprites: sprites}}
  end

  def leave(user_id) do
    Endpoint.broadcast!("games:play", "player:leave", %{id: user_id, type: :player})
    PlayerSupervisor.stop(user_id)
  end

  def update_position(user_id, %{"x" => x, "y" => y}) do
    pid = :global.whereis_name(user_id)
    Player.update_position(pid, %{x: x, y: y})
  end

  def get_cards() do
    %{
      "1": "keith",
      "2": "tanya",
      "3": "mum",
      "4": "dad",
      "5": "bill",
      "6": "ben",
    }
  end
end
