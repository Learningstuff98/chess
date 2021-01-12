class Piece < ApplicationRecord
  belongs_to :game

  def update_x_and_y(destination_x, destination_y)
    self.update_attribute(:x, destination_x)
    self.update_attribute(:y, destination_y)
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
    if distance_of_y == 1
      if [0, 1].include?(distance_of_x)
        return true
      end
    end
    if distance_of_y.zero?
      if distance_of_x == 1
        return true
      end
    end
  end

  def valid_move?
    if self.piece_type == "rook"
      if self.horizontal_move? || self.verticle_move?
        self.update_x_and_y(self.destination_x, self.destination_y)
      end
    end
    if self.piece_type == "bishop" 
      if self.diagonal_move?
        self.update_x_and_y(self.destination_x, self.destination_y)
      end
    end
    if self.piece_type == "queen"
      if self.horizontal_move? || self.verticle_move? || self.diagonal_move?
        self.update_x_and_y(self.destination_x, self.destination_y)
      end
    end
    if self.piece_type == "king"
      if self.king_move?
        self.update_x_and_y(self.destination_x, self.destination_y)
      end
    end
    # self.update_x_and_y(self.destination_x, self.destination_y)
  end

end
