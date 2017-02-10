defmodule Revolution.PlayChannel do
  use Revolution.Web, :channel
  alias Revolution.Game
  require Logger

  def join("games:play", payload, socket) do
    if authorized?(payload) do
      Logger.debug "#{socket.assigns.user_id} joined the Play channel"
      case Game.join(socket.assigns.user_id) do
        {:ok, response} ->
          {:ok, response, socket}
        error ->
          error
      end
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def terminate(_reason, socket) do
    Logger.debug "#{socket.assigns.user_id} left the Play channel"
    Game.leave(socket.assigns.user_id)
    socket
  end

  def handle_in("get_cards", payload, socket) do
    # here is where we return the cards...
    push socket, "get_cards", %{
      cards: Game.get_cards()
    }
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
  defp authorized?(_payload) do
    true
  end
end
