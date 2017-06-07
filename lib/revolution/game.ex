defmodule Revolution.Game do
  require Logger
  use GenServer
  alias Revolution.{
                    Endpoint,
                    Player,
                    PlayerSupervisor,
                    Match
                   }

  ### PUBLIC API ###

  def join(user_id) do
    Logger.debug "#{user_id} joined the Game"
    PlayerSupervisor.start(user_id)
    sprites = PlayerSupervisor.get_all
    {:ok, %{id: user_id, sprites: sprites}}
  end

  def leave(user_id) do
    Logger.debug "#{user_id} left the Game"
    Endpoint.broadcast!("games:play", "player:leave", %{id: user_id, type: :player})
    PlayerSupervisor.stop(user_id)
  end

  def update_position(user_id, %{"x" => x, "y" => y}) do
    pid = :global.whereis_name(user_id)
    Player.update_position(pid, %{x: x, y: y})
  end

  def get_cards() do
    Match.get_cards()
  end

  def check_pair(x, y) do
    Logger.debug "Match submitted: #{x} #{y}"
    Match.check_pair(x, y)
  end

  ### GENSERVER CALLBACKS ###

  def init(state) do
    {:ok, state}
  end

  def handle_call(:inspect, _from, state) do
    {:reply, state, state}
  end

  # def handle_call(:get_cards, from, %{cards} = state) do
  #   {:reply, cards, state}
  # end
end
