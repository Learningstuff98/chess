class Piece < ApplicationRecord
  belongs_to :game

  def update_x_and_y
    update(x: destination_x)
    update(y: destination_y)
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

  def get_horizontal_or_verticle_path
    coordinates = []
    if self.destination_x != self.x
      x_value = self.x + 1 if self.destination_x > self.x
      x_value = self.x - 1 if self.destination_x < self.x
      while x_value != self.destination_x
        coordinates.push([x_value, self.y])
        x_value += 1 if self.destination_x > self.x
        x_value -= 1 if self.destination_x < self.x
      end
    else
      y_value = self.y + 1 if self.destination_y > self.y
      y_value = self.y - 1 if self.destination_y < self.y
      while y_value != self.destination_y
        coordinates.push([self.x, y_value])
        y_value += 1 if self.destination_y > self.y
        y_value -= 1 if self.destination_y < self.y
      end
    end
    coordinates
  end

  def get_diagonal_path
    coordinates = []
    if self.destination_x > self.x
      x_value = self.x + 1
      y_value = self.y + 1 if self.destination_y > self.y
      y_value = self.y - 1 if self.destination_y < self.y
      while x_value < self.destination_x
        coordinates.push([x_value, y_value])
        x_value += 1
        y_value += 1 if self.destination_y > self.y
        y_value -= 1 if self.destination_y < self.y
      end
    else
      x_value = self.x - 1
      y_value = self.y - 1 if self.destination_y < self.y
      y_value = self.y + 1 if self.destination_y > self.y
      while x_value > self.destination_x
        coordinates.push([x_value, y_value])
        x_value -= 1
        y_value -= 1 if self.destination_y < self.y
        y_value += 1 if self.destination_y > self.y
      end
    end
    coordinates
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
            if self.path_clear?(self.get_horizontal_or_verticle_path)
              self.update_x_and_y
              self.game.invert_turn
            end
          end
        end
        if self.piece_type == "bishop"
          if self.diagonal_move?
            if self.path_clear?(self.get_diagonal_path)
              self.update_x_and_y
              self.game.invert_turn
            end
          end
        end
        if self.piece_type == "queen"
          if self.diagonal_move?
            if self.path_clear?(self.get_diagonal_path)
              self.update_x_and_y
              self.game.invert_turn
            end
          end
          if self.horizontal_move? || self.verticle_move?
            if self.path_clear?(self.get_horizontal_or_verticle_path)
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
