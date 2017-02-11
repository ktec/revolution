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
      "1": ["keith", 100, 100],
      "2": ["tanya", 600, 120],
      "3": ["mum", 300, 140],
      "4": ["dad", 400, 260],
      "5": ["bill", 500, 180],
      "6": ["ben", 200, 200],
    }
  end

  def submit_match("1", "2"), do: :match
  def submit_match("2", "1"), do: :match
  def submit_match("3", "4"), do: :match
  def submit_match("4", "3"), do: :match
  def submit_match("5", "6"), do: :match
  def submit_match("6", "5"), do: :match
  def submit_match(_, _), do: :no_match
end
