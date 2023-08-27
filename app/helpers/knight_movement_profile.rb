module KnightMovementProfile
  def self.knight_move?(destination_x, destination_y, x, y)
    distance_of_x = (destination_x - x).abs
    distance_of_y = (destination_y - y).abs
    return distance_of_y == 1 if distance_of_x == 2
    
    distance_of_y == 2 if distance_of_x == 1
  end
end
