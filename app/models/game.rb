class Game < ApplicationRecord
  belongs_to :user
  has_many :pieces, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.vacant_games
    Game.select { |game| !game.as_white || !game.as_black }
  end

  def invert_turn
    update(whites_turn: !whites_turn)
  end

  def victory?
    pieces.each do |piece|
      if piece.piece_type == "king" && !piece.in_play
        if piece.color == "black"
          update(winner_username: as_white)
        else
          update(winner_username: as_black)
        end
      end
    end
  end

  def assign_host(current_user)
    if host_as_white
      update(as_white: current_user.username)
    else
      update(as_black: current_user.username)
    end
  end

  def assign_guest(current_user)
    return unless current_user != user

    update(as_white: current_user.username) unless as_white
    update(as_black: current_user.username) unless as_black
  end

  def make_pieces
    make_kings
    make_queens
    make_bishops
    make_rooks
    make_pawns
    make_knights
  end

  def make_pawns
    [1, 2, 3, 4, 5, 6, 7, 8].each do |x_value|
      make_piece("pawn", "black", x_value, 7, "♙")
      make_piece("pawn", "white", x_value, 2, "♙")
    end
  end

  def make_rooks
    make_piece("rook", "white", 1, 1, "♜")
    make_piece("rook", "white", 8, 1, "♜")
    make_piece("rook", "black", 1, 8, "♜")
    make_piece("rook", "black", 8, 8, "♜")
  end

  def make_knights
    make_piece("knight", "white", 2, 1, "♞")
    make_piece("knight", "white", 7, 1, "♞")
    make_piece("knight", "black", 2, 8, "♞")
    make_piece("knight", "black", 7, 8, "♞")
  end

  def make_bishops
    make_piece("bishop", "white", 3, 1, "♝")
    make_piece("bishop", "white", 6, 1, "♝")
    make_piece("bishop", "black", 3, 8, "♝")
    make_piece("bishop", "black", 6, 8, "♝")
  end

  def make_kings
    make_piece("king", "black", 5, 8, "♚")
    make_piece("king", "white", 5, 1, "♚")
  end

  def make_queens
    make_piece("queen", "white", 4, 1, "♛")
    make_piece("queen", "black", 4, 8, "♛")
  end

  def make_piece(piece_type, color, x_val, y_val, icon)
    pieces.create(
      piece_type: piece_type,
      color: color,
      x: x_val,
      y: y_val,
      icon: icon
    )
  end
end
