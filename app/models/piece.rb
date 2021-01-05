class Piece < ApplicationRecord
  belongs_to :game

  def update_x_and_y(destination_x, destination_y)
    self.update_attribute(:x, destination_x)
    self.update_attribute(:y, destination_y)
  end

end
