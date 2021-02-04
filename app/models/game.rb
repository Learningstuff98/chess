class Game < ApplicationRecord
  belongs_to :user
  has_many :pieces
  has_many :lobby_tokens

  def invert_turn # test
    self.update_attribute(:whites_turn, !self.whites_turn)
  end

  def victory?
    self.pieces.each do |piece|
      if piece.piece_type == "king" && !piece.in_play
        if piece.color == "black"
          self.update_attribute(:winner_username, self.as_white)
        else
          self.update_attribute(:winner_username, self.as_black)
        end
      end
    end
  end

  def create_lobby_token(current_user)
    self.lobby_tokens.create(
      host_username: current_user.username,
      host_color: self.get_host_color
    )
  end

  def get_host_color
    return "white" if self.host_as_white
    "black"
  end

  def assign_host(current_user)
    if self.host_as_white
      self.update_attribute(:as_white, current_user.username)
    else
      self.update_attribute(:as_black, current_user.username)
    end
  end

  def assign_guest(current_user)
    if current_user != self.user 
      if !self.as_white
        self.update_attribute(:as_white, current_user.username)
      end
      if !self.as_black
        self.update_attribute(:as_black, current_user.username)
      end
    end
  end

  def manage_token
    if self.as_white && self.as_black
      self.lobby_tokens.destroy_all
    end
  end

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
