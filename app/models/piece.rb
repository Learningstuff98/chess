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
    if self.y == self.destination_y
      if self.destination_x > self.x
        starting_point = self.x
        ending_point = self.destination_x
      else
        starting_point = self.destination_x
        ending_point = self.x
      end
    end
    if self.x == self.destination_x
      if self.destination_y > self.y
        starting_point = self.y
        ending_point = self.destination_y
      else
        starting_point = self.destination_y
        ending_point = self.y
      end
    end
    ((starting_point + 1)...ending_point).each do |value|
      if self.x == self.destination_x
        coordinates.push([self.destination_x, value])
      else
        coordinates.push([value, self.destination_y])
      end
    end
    puts coordinates.inspect
    coordinates
  end

  def valid_move?
    if self.piece_type == "rook"
      if self.horizontal_move? || self.verticle_move?
        self.get_horizontal_or_verticle_path
        self.update_x_and_y
      end
    end
    if self.piece_type == "bishop" 
      if self.diagonal_move?
        self.update_x_and_y
      end
    end
    if self.piece_type == "queen"
      if self.horizontal_move? || self.verticle_move? || self.diagonal_move?
        self.update_x_and_y
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
      self.update_x_and_y
    end
  end

end
