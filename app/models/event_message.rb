class EventMessage < ApplicationRecord
  belongs_to :game

  def self.create_capture_message(game, piece, selected_piece)
    event_message = game.event_messages.create(
      content: "
        The #{piece.piece_type} at #{translate_coordinates_to_board_format(piece)} was captured.
        The #{selected_piece.piece_type} moved to #{translate_coordinates_to_board_format(piece)}.
      "
    )
    SendEventMessageJob.perform_later(game, event_message)
  end

  def self.create_movement_message(game, piece)
    event_message = game.event_messages.create(
      content: "The #{piece.piece_type} moved to #{translate_coordinates_to_board_format(piece)}."
    )
    SendEventMessageJob.perform_later(game, event_message)
  end

  def self.create_illegal_jump_over_message(game, selected_piece, piece)
    event_message = game.event_messages.create(
      content: "
        The #{selected_piece.piece_type} at #{translate_coordinates_to_board_format(selected_piece)}
        isn't allowed to jump over the #{piece.piece_type} at
        #{translate_coordinates_to_board_format(piece)}.
      "
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
