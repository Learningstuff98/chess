class SendCommentJob < ApplicationJob
  queue_as :default

  def perform(game)
    ActionCable.server.broadcast("game_channel", game: game, comments: game.comments)
  end
end
