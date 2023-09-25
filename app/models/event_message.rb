class EventMessage < ApplicationRecord
  belongs_to :game

  def self.create_event_message(game, selected_piece, piece)
    event_message = game.event_messages.create(
      content: "The #{selected_piece.piece_type} isn't allowed to jump over the #{piece.piece_type} at #{translate_coordinates_to_board_format(piece)}."
    )
    SendEventMessageJob.perform_later(game, event_message)
  end

  NUMBER_TO_LETTER_VALUES = {
    1 => "a",
    2 => "b",
    3 => "c",
    4 => "d",
    5 => "e",
    6 => "f",
    7 => "g",
    8 => "h"
  }.freeze

  def self.translate_coordinates_to_board_format(piece)
    "#{NUMBER_TO_LETTER_VALUES[piece.x]}#{piece.y}"
  end
end
