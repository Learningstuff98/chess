module GeneralMovementProfile
  def self.horizontal_move?(x, y, destination_x, destination_y)
    destination_y == y && destination_x != x
  end

  def self.verticle_move?(x, y, destination_x, destination_y)
    destination_y != y && destination_x == x
  end
end
