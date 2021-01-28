class SendLobbyTokensJob < ApplicationJob
  queue_as :default

  def perform
    ActionCable.server.broadcast("lobby_channel", lobby_tokens: LobbyToken.all)
  end
end
