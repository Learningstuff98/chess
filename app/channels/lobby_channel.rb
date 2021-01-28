class LobbyChannel < ApplicationCable::Channel
  def subscribed
    stream_from "lobby_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
