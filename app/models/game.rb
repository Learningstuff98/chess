class Game < ApplicationRecord
  belongs_to :user
  has_many :pieces

  def make_pieces
    self.make_piece("rook", "white", 1, 1, "♜")
    self.make_piece("rook", "white", 8, 1, "♜")
    self.make_piece("knight", "white", 2, 1, "♞")
    self.make_piece("knight", "white", 7, 1, "♞")
    self.make_piece("bishop", "white", 3, 1, "♝")
    self.make_piece("bishop", "white", 6, 1, "♝")
    self.make_piece("king", "white", 5, 1, "♚")
    self.make_piece("queen", "white", 4, 1, "♛")

    self.make_piece("rook", "black", 1, 8, "♜")
    self.make_piece("rook", "black", 8, 8, "♜")
    self.make_piece("knight", "black", 2, 8, "♞")
    self.make_piece("knight", "black", 7, 8, "♞")
    self.make_piece("bishop", "black", 3, 8, "♝")
    self.make_piece("bishop", "black", 6, 8, "♝")
    self.make_piece("king", "black", 5, 8, "♚")
    self.make_piece("queen", "black", 4, 8, "♛")

    [1, 2, 3, 4, 5, 6, 7, 8].each do |x_value|
      self.make_piece("pawn", "black", x_value, 7, "♙")
      self.make_piece("pawn", "white", x_value, 2, "♙")
    end
  end

  def make_piece(piece_type, color, x, y, icon)
    self.pieces.create(
      piece_type: piece_type,
      color: color,
      x: x,
      y: y,
      icon: icon
    )
  end

end
