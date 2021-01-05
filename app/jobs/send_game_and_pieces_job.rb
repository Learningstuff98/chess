class SendGameAndPiecesJob < ApplicationJob
  queue_as :default

  def perform(game)
    ActionCable.server.broadcast("game_channel", game: game, pieces: game.pieces)
  end
end
