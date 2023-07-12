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

  def king_move?
    distance_of_x = (destination_x - x).abs
    distance_of_y = (destination_y - y).abs
    return [0, 1].include?(distance_of_x) if distance_of_y == 1

    distance_of_x == 1 if distance_of_y.zero?
  end

  def knight_move?
    distance_of_x = (destination_x - x).abs
    distance_of_y = (destination_y - y).abs
    return distance_of_y == 1 if distance_of_x == 2

    distance_of_y == 2 if distance_of_x == 1
  end

  def horizontal_or_verticle_path
    if x != destination_x
      horizontal_path
    else
      verticle_path
    end
  end

  def range(value, destination_value)
    if destination_value > value
      ((value + 1)..(destination_value - 1)).to_a
    else
      ((destination_value + 1)..(value - 1)).to_a
    end
  end

  def horizontal_path
    range(x, destination_x).map do |x_value|
      [x_value, y]
    end
  end

  def verticle_path
    range(y, destination_y).map do |y_value|
      [x, y_value]
    end
  end

  def diagonal_path
    y_values = diagonal_y_values
    range(x, destination_x).map.with_index do |x_value, index|
      [x_value, y_values[index]]
    end
  end

  def diagonal_y_values
    y_values = range(y, destination_y)
    if destination_x > x
      y_values = y_values.reverse if destination_y < y
    elsif destination_y > y
      y_values = y_values.reverse
    end
    y_values
  end

  def path_clear?(path)
    path.each do |coord_pair|
      self.game.pieces.each do |piece|
        if piece.x == coord_pair[0] && piece.y == coord_pair[1]
          return false
        end
      end
    end
    true
  end

  def friendly_capture?
    self.game.pieces.each do |piece|
      if piece.x == self.destination_x && piece.y == self.destination_y
        return piece.color == self.color
      end
    end
    false
  end

  def tile_has_piece?(tile_x, tile_y)
    self.game.pieces.each do |piece|
      if piece.x == tile_x && piece.y == tile_y
        return true
      end
    end
    false
  end

  def forward_pawn_move?(operation)
    if self.x == self.destination_x
      if self.destination_y == self.y.send(operation, 1)
        !self.tile_has_piece?(self.destination_x, self.destination_y)
      end
    end
  end

  def double_jump?(operation, starting_y)
    if self.x == self.destination_x
      if self.y == starting_y
        if self.destination_y == starting_y.send(operation, 2)
          !self.tile_has_piece?(self.destination_x, self.destination_y) &&
          !self.tile_has_piece?(self.destination_x, self.y.send(operation, 1))
        end
      end
    end
  end

  def pawn_capturing?(operation)
    if self.destination_y == self.y.send(operation, 1)
      if [self.x + 1, self.x - 1].include?(self.destination_x)
        self.tile_has_piece?(self.destination_x, self.destination_y)
      end
    end
  end

  def promoted?(origional_piece_type)
    origional_piece_type != self.piece_type
  end

  def on_row?(promotion_row)
    self.y == promotion_row
  end

  def current_turn?(current_user)
    if self.game.whites_turn
      return current_user.username == self.game.as_white
    else
      current_user.username == self.game.as_black
    end
  end

  def correct_color?(current_user)
    if self.color === "white"
      return current_user.username == self.game.as_white
    else
      current_user.username == self.game.as_black
    end
  end

  def valid_move?(current_user)
    if self.correct_color?(current_user)
      if !self.friendly_capture? && self.current_turn?(current_user)
        if self.piece_type == "rook"
          if self.horizontal_move? || self.verticle_move?
            if self.path_clear?(self.horizontal_or_verticle_path)
              self.update_x_and_y
              self.game.invert_turn
            end
          end
        end
        if self.piece_type == "bishop"
          if self.diagonal_move?
            if self.path_clear?(self.diagonal_path)
              self.update_x_and_y
              self.game.invert_turn
            end
          end
        end
        if self.piece_type == "queen"
          if self.diagonal_move?
            if self.path_clear?(self.diagonal_path)
              self.update_x_and_y
              self.game.invert_turn
            end
          end
          if self.horizontal_move? || self.verticle_move?
            if self.path_clear?(self.horizontal_or_verticle_path)
              self.update_x_and_y
              self.game.invert_turn
            end
          end
        end
        if self.piece_type == "king"
          if self.king_move?
            self.update_x_and_y
            self.game.invert_turn
          end
        end
        if self.piece_type == "knight"
          if self.knight_move?
            self.update_x_and_y
            self.game.invert_turn
          end
        end
        if self.piece_type == "pawn"
          if self.color == "white"
            if self.forward_pawn_move?(:+) || self.pawn_capturing?(:+)
              self.update_x_and_y
              if !self.on_row?(8)
                self.game.invert_turn
              end
            end
            if self.double_jump?(:+, 2)
              self.update_x_and_y
              self.game.invert_turn
            end
          else
            if self.forward_pawn_move?(:-) || self.pawn_capturing?(:-)
              self.update_x_and_y
              if !self.on_row?(1)
                self.game.invert_turn
              end
            end
            if self.double_jump?(:-, 7)
              self.update_x_and_y
              self.game.invert_turn
            end
          end
        end
      end
    end
  end
end
