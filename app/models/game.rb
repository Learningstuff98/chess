class Game < ApplicationRecord
  belongs_to :user
  has_many :pieces

  def make_pieces # make a function that spawns a piece with given inputs.
    self.make_white_pieces
    self.make_black_pieces
  end

  def make_white_pieces
    self.pieces.create(
      piece_type: "rook",
      color: "white",
      x: 1,
      y: 1,
      icon: "♜"
    )
    self.pieces.create(
      piece_type: "rook",
      color: "white",
      x: 8,
      y: 1,
      icon: "♜"
    )

    self.pieces.create(
      piece_type: "knight",
      color: "white",
      x: 2,
      y: 1,
      icon: "♞"
    )
    self.pieces.create(
      piece_type: "knight",
      color: "white",
      x: 7,
      y: 1,
      icon: "♞"
    )

    self.pieces.create(
      piece_type: "bishop",
      color: "white",
      x: 3,
      y: 1,
      icon: "♝"
    )
    self.pieces.create(
      piece_type: "bishop",
      color: "white",
      x: 6,
      y: 1,
      icon: "♝"
    )

    self.pieces.create(
      piece_type: "king",
      color: "white",
      x: 5,
      y: 1,
      icon: "♚"
    )

    self.pieces.create(
      piece_type: "queen",
      color: "white",
      x: 4,
      y: 1,
      icon: "♛"
    )

    [1, 2, 3, 4, 5, 6, 7, 8].each do |x_value|
      self.pieces.create(
        piece_type: "pawn",
        color: "white",
        x: x_value,
        y: 2,
        icon: "♙"
      )
    end
  end

  def make_black_pieces
    self.pieces.create(
      piece_type: "rook",
      color: "black",
      x: 1,
      y: 8,
      icon: "♜"
    )
    self.pieces.create(
      piece_type: "rook",
      color: "black",
      x: 8,
      y: 8,
      icon: "♜"
    )

    self.pieces.create(
      piece_type: "knight",
      color: "black",
      x: 2,
      y: 8,
      icon: "♞"
    )
    self.pieces.create(
      piece_type: "knight",
      color: "black",
      x: 7,
      y: 8,
      icon: "♞"
    )

    self.pieces.create(
      piece_type: "bishop",
      color: "black",
      x: 3,
      y: 8,
      icon: "♝"
    )
    self.pieces.create(
      piece_type: "bishop",
      color: "black",
      x: 6,
      y: 8,
      icon: "♝"
    )

    self.pieces.create(
      piece_type: "king",
      color: "black",
      x: 5,
      y: 8,
      icon: "♚"
    )

    self.pieces.create(
      piece_type: "queen",
      color: "black",
      x: 4,
      y: 8,
      icon: "♛"
    )

    [1, 2, 3, 4, 5, 6, 7, 8].each do |x_value|
      self.pieces.create(
        piece_type: "pawn",
        color: "black",
        x: x_value,
        y: 7,
        icon: "♙"
      )
    end
  end

end
