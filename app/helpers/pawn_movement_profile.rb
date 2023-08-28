module PawnMovementProfile
  def self.tile_has_piece?(tile_x, tile_y, game)
    game.pieces.each do |piece|
      return true if piece.x == tile_x && piece.y == tile_y
    end
    false
  end

  def self.forward_pawn_move?(destination_x, destination_y, x, y, operation, game)
    x == destination_x &&
      destination_y == y.send(operation, 1) &&
      !tile_has_piece?(destination_x, destination_y, game)
  end
end
