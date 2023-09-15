module GeneralMovementProfile
  def self.horizontal_move?(x, y, destination_x, destination_y)
    destination_y == y && destination_x != x
  end

  def self.verticle_move?(x, y, destination_x, destination_y)
    destination_y != y && destination_x == x
  end

  def self.diagonal_move?(x, y, destination_x, destination_y)
    (x - destination_x).abs == (y - destination_y).abs
  end
end
