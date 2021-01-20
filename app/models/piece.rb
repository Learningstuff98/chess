class Piece < ApplicationRecord
  belongs_to :game

  def update_x_and_y
    self.update_attribute(:x, self.destination_x)
    self.update_attribute(:y, self.destination_y)
  end

  def capture_piece
    self.game.pieces.each do |piece|
      if self != piece
        if piece.x == self.x && piece.y == self.y
          piece.update_attribute(:x, 100)
          piece.update_attribute(:in_play, false)
        end
      end
    end
  end

  def horizontal_move?
    self.destination_y == self.y && self.destination_x != self.x
  end

  def verticle_move?
    self.destination_y != self.y && self.destination_x == self.x
  end

  def diagonal_move?
    (self.x - self.destination_x).abs == (self.y - self.destination_y).abs
  end

  def king_move?
    distance_of_x = (self.destination_x - self.x).abs
    distance_of_y = (self.destination_y - self.y).abs
    return [0, 1].include?(distance_of_x) if distance_of_y == 1
    return distance_of_x == 1 if distance_of_y.zero?
  end

  def knight_move?
    distance_of_x = (self.destination_x - self.x).abs
    distance_of_y = (self.destination_y - self.y).abs
    return distance_of_y == 1 if distance_of_x == 2
    return distance_of_y == 2 if distance_of_x == 1
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

  def has_piece?(destination_x, destination_y) # test
    self.game.pieces.each do |piece|
      if piece.x == destination_x && piece.y == destination_y
        return true
      end
    end
    false
  end

  def forward_pawn_move?(operation) # test
    if self.x == self.destination_x
      if self.destination_y == self.y.send(operation, 1)
        !self.has_piece?(self.destination_x, self.destination_y)
      end
    end
  end

  def double_jump?(operation, starting_y) # test
    if self.x == self.destination_x
      if self.y == starting_y
        if self.destination_y == starting_y.send(operation, 2)
          !self.has_piece?(self.destination_x, self.destination_y) &&
          !self.has_piece?(self.destination_x, self.y.send(operation, 1))
        end
      end
    end
  end

  def pawn_capturing?(operation) # test
    if self.destination_y == self.y.send(operation, 1)
      if [self.x + 1, self.x - 1].include?(self.destination_x)
        self.has_piece?(self.destination_x, self.destination_y)
      end
    end
  end

  def valid_move?
    if !self.friendly_capture?
      if self.piece_type == "rook"
        if self.horizontal_move? || self.verticle_move?
          if self.path_clear?(self.get_horizontal_or_verticle_path)
            self.update_x_and_y
          end
        end
      end
      if self.piece_type == "bishop" 
        if self.diagonal_move?
          if self.path_clear?(self.get_diagonal_path)
            self.update_x_and_y
          end
        end
      end
      if self.piece_type == "queen"
        if self.horizontal_move? || self.verticle_move?
          if self.path_clear?(self.get_horizontal_or_verticle_path)
            self.update_x_and_y
          end
        end
        if self.diagonal_move?
          if self.path_clear?(self.get_diagonal_path)
            self.update_x_and_y
          end
        end
      end
      if self.piece_type == "king"
        if self.king_move?
          self.update_x_and_y
        end
      end
      if self.piece_type == "knight"
        if self.knight_move?
          self.update_x_and_y
        end
      end
      if self.piece_type == "pawn"
        if self.color == "white"
          self.update_x_and_y if self.forward_pawn_move?(:+)
          self.update_x_and_y if self.double_jump?(:+, 2)
          self.update_x_and_y if self.pawn_capturing?(:+)
        else
          self.update_x_and_y if self.forward_pawn_move?(:-)
          self.update_x_and_y if self.double_jump?(:-, 7)
          self.update_x_and_y if self.pawn_capturing?(:-)
        end
      end
    end
  end
end
