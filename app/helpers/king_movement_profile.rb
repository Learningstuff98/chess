module KingMovementProfile
  def self.king_move?(destination_x, destination_y, x, y)
    distance_of_x = (destination_x - x).abs
    distance_of_y = (destination_y - y).abs
    return [0, 1].include?(distance_of_x) if distance_of_y == 1

    distance_of_x == 1 if distance_of_y.zero?
  end
end
