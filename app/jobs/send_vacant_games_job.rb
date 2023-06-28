class SendVacantGamesJob < ApplicationJob
  queue_as :default

  def perform
    ActionCable.server.broadcast("lobby_channel", games: Game.vacant_games)
  end
end
