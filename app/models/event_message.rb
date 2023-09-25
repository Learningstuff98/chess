class EventMessage < ApplicationRecord
  belongs_to :game

  def self.create_event_message(game, selected_piece, piece)
    event_message = game.event_messages.create(
      content: "The #{selected_piece.piece_type} isn't allowed to jump over the #{piece.piece_type}."
    )
    SendEventMessageJob.perform_later(game, event_message)
  end
end
