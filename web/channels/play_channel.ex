defmodule Revolution.PlayChannel do
  use Revolution.Web, :channel
  alias Revolution.Game
  require Logger

  def join("games:play", payload, socket) do
    if authorized?(payload) do
      case Game.join(socket.assigns.user_id) do
        {:ok, response} -> {:ok, response, socket}
                  error -> error
      end
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def terminate(_reason, socket) do
    Game.leave(socket.assigns.user_id)
    socket
  end

  def handle_in("get_cards", payload, socket) do
    # here is where we return the cards...
    push socket, "get_cards", %{ cards: Game.get_cards() }
    {:noreply, socket}
  end

  def handle_in("submit_match", payload, socket) do
    %{"left" => left, "right" => right} = payload
    case Game.check_pair(left, right) do
         :match -> remove_cards(socket, [left, right])
      :no_match -> push socket, "no_match", %{"msg" => "No match found"}
    end
    {:noreply, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # broadcast position data to everyone else
  def handle_in("position", payload, socket) do
    broadcast_from socket, "position", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(payload) do
    true
  end

  defp authorized?()

  defp remove_cards(socket, cards) do
    broadcast socket, "remove_cards", %{"cards" => cards}
  end
end
