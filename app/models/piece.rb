class Piece < ApplicationRecord
  belongs_to :game

  def update_x_and_y
    update(x: destination_x, y: destination_y)
  end

  def capture_piece
    game.pieces.each do |piece|
      next if self == piece

      piece.update(x: 100, in_play: false) if piece.x == x && piece.y == y
    end
  end

  def horizontal_move?
    destination_y == y && destination_x != x
  end

  def verticle_move?
    destination_y != y && destination_x == x
  end

  def diagonal_move?
    (x - destination_x).abs == (y - destination_y).abs
  end

  def horizontal_or_verticle_path
    if x != destination_x
      PathFinder.horizontal_path(x, y, destination_x)
    else
      PathFinder.verticle_path(x, y, destination_y)
    end
  end

  def path_clear?(path)
    path.each do |coord_pair|
      game.pieces.each do |piece|
        return false if piece.x == coord_pair.first && piece.y == coord_pair.last
      end
    end
    true
  end

  def friendly_capture?
    game.pieces.each do |piece|
      return piece.color == color if piece.x == destination_x && piece.y == destination_y
    end
    false
  end

  def current_turn?(current_user)
    return current_user.username == game.as_white if game.whites_turn

    current_user.username == game.as_black
  end

  def correct_color?(current_user)
    return current_user.username == game.as_white if color == "white"

    current_user.username == game.as_black
  end

  def move_horizontaly_or_vertically
    return unless horizontal_move? || verticle_move?

    update_x_and_y && game.invert_turn if path_clear?(horizontal_or_verticle_path)
  end

  def move_diagonally
    return unless diagonal_move?

    update_x_and_y && game.invert_turn if path_clear?(PathFinder.diagonal_path(x, y, destination_x, destination_y))
  end

  def move_queen
    move_diagonally || move_horizontaly_or_vertically
  end

  def handle_pawn_movement
    if color == "white"
      move_pawn(:+, 8, 2)
    else
      move_pawn(:-, 1, 7)
    end
  end

  def handle_double_jump(starting_row, operation)
    update_x_and_y && game.invert_turn if PawnMovementProfile.double_jump?(
      destination_x,
      destination_y,
      x,
      y,
      operation,
      starting_row,
      game
    )
  end

  def move_pawn(operation, promotion_row, starting_row)
    if PawnMovementProfile.forward_pawn_move_or_pawn_capturing?(destination_x, destination_y, x, y, operation, game)
      update_x_and_y
      game.invert_turn unless y == promotion_row
    end
    handle_double_jump(starting_row, operation)
  end

  def move_knight
    update_x_and_y && game.invert_turn if KnightMovementProfile.knight_move?(destination_x, destination_y, x, y)
  end

  def move_king
    update_x_and_y && game.invert_turn if KingMovementProfile.king_move?(destination_x, destination_y, x, y)
  end

  def valid_move?(current_user)
    return unless correct_color?(current_user) && !friendly_capture? && current_turn?(current_user)

    move_horizontaly_or_vertically if piece_type == "rook"
    move_diagonally if piece_type == "bishop"
    move_queen if piece_type == "queen"
    move_king if piece_type == "king"
    move_knight if piece_type == "knight"
    handle_pawn_movement if piece_type == "pawn"
  end
end
