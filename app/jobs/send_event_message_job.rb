class SendEventMessageJob < ApplicationJob
  queue_as :default
  
  def perform(game, event_message)
    ActionCable.server.broadcast("game_channel", game: game, event_message: event_message)
  end
end
