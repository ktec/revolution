defmodule Revolution.LobbyChannel do
  use Revolution.Web, :channel
  require Logger

  def join("games:lobby", payload, socket) do
    if authorized?(payload) do
      Logger.debug "#{socket.assigns.user_id} joined the Lobby channel"
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def terminate(_reason, socket) do
    Logger.debug "#{socket.assigns.user_id} left the Lobby channel"
    socket
  end

  def handle_in("position", payload, socket) do
    broadcast_from socket, "position", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
