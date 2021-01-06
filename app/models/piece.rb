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

end
