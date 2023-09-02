module PawnMovementProfile
  def self.tile_has_piece?(tile_x, tile_y, game)
    game.pieces.each do |piece|
      return true if piece.x == tile_x && piece.y == tile_y
    end
    false
  end

  def self.forward_pawn_move_or_pawn_capturing?(destination_x, destination_y, x, y, operation, game)
    forward_pawn_move?(destination_x, destination_y, x, y, operation, game) ||
      pawn_capturing?(destination_x, destination_y, x, y, operation, game)
  end

  def self.forward_pawn_move?(destination_x, destination_y, x, y, operation, game)
    x == destination_x &&
      destination_y == y.send(operation, 1) &&
      !tile_has_piece?(destination_x, destination_y, game)
  end

  def self.pawn_capturing?(destination_x, destination_y, x, y, operation, game)
    destination_y == y.send(operation, 1) &&
      [x + 1, x - 1].include?(destination_x) &&
      tile_has_piece?(destination_x, destination_y, game)
  end

  def self.double_jump?(destination_x, destination_y, x, y, operation, starting_y, game)
    x == destination_x &&
      y == starting_y &&
      destination_y == starting_y.send(operation, 2) &&
      !tile_has_piece?(destination_x, destination_y, game) &&
      !tile_has_piece?(destination_x, y.send(operation, 1), game)
  end

  # look at the promoted? function too.
end
