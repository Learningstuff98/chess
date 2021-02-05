require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "update_x_and_y function" do
    it "should update the x and y attributes" do
      piece = FactoryBot.create(:piece)
      piece.update_x_and_y
      expect(piece.x).to eq 4
      expect(piece.y).to eq 4
    end
  end

  describe "capture_piece function" do
    it "should remove any pieces that have matching coordinates from play" do
      game = FactoryBot.create(:game)
      game.pieces.create(x: 1, y: 2)
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:x, 1)
      piece.update_attribute(:y, 2)
      game.pieces.push(piece)
      piece.capture_piece
      expect(game.pieces.first.in_play).to eq false
      expect(game.pieces.first.x).to eq 100
    end

    it "should only capture pieces with matching coordinates" do
      game = FactoryBot.create(:game)
      game.pieces.create(x: 1, y: 2)
      piece = FactoryBot.create(:piece)
      game.pieces.push(piece)
      piece.capture_piece
      expect(game.pieces.first.in_play).to eq true
      expect(game.pieces.first.x).to eq 1
    end

    it "should not capture itself" do
      game = FactoryBot.create(:game)
      piece = FactoryBot.create(:piece)
      game.pieces.push(piece)
      piece.capture_piece
      expect(game.pieces.first.in_play).to eq true
      expect(game.pieces.first.x).to eq 5
    end
  end

  describe "get_horizontal_or_verticle_path function" do
    it "should collect a list of coordinates when going west to east" do
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:x, 1)
      piece.update_attribute(:y, 4)
      piece.update_attribute(:destination_x, 8)
      piece.update_attribute(:destination_y, 4)
      expect(piece.get_horizontal_or_verticle_path).to eq [[2, 4], [3, 4], [4, 4], [5, 4], [6, 4], [7, 4]]
    end

    it "should collect a list of coordinates when going east to west" do
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:x, 8)
      piece.update_attribute(:y, 4)
      piece.update_attribute(:destination_x, 1)
      piece.update_attribute(:destination_y, 4)
      expect(piece.get_horizontal_or_verticle_path).to eq [[7, 4], [6, 4], [5, 4], [4, 4], [3, 4], [2, 4]]
    end

    it "should collect a list of coordinates when going south to north" do
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:x, 1)
      piece.update_attribute(:y, 1)
      piece.update_attribute(:destination_x, 1)
      piece.update_attribute(:destination_y, 8)
      expect(piece.get_horizontal_or_verticle_path).to eq [[1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7]]
    end

    it "should collect a list of coordinates when going north to south" do
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:x, 1)
      piece.update_attribute(:y, 8)
      piece.update_attribute(:destination_x, 1)
      piece.update_attribute(:destination_y, 1)
      expect(piece.get_horizontal_or_verticle_path).to eq [[1, 7], [1, 6], [1, 5], [1, 4], [1, 3], [1, 2]]
    end
  end

  describe "get_diagonal_path function" do
    it "should collect a list of coordinates when going north west" do
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:x, 8)
      piece.update_attribute(:y, 1)
      piece.update_attribute(:destination_x, 1)
      piece.update_attribute(:destination_y, 8)
      expect(piece.get_diagonal_path).to eq [[7, 2], [6, 3], [5, 4], [4, 5], [3, 6], [2, 7]]
    end

    it "should collect a list of coordinates when going south east" do
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:x, 1)
      piece.update_attribute(:y, 8)
      piece.update_attribute(:destination_x, 8)
      piece.update_attribute(:destination_y, 1)
      expect(piece.get_diagonal_path).to eq [[2, 7], [3, 6], [4, 5], [5, 4], [6, 3], [7, 2]]
    end

    it "should collect a list of coordinates when going north east" do
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:x, 1)
      piece.update_attribute(:y, 1)
      piece.update_attribute(:destination_x, 8)
      piece.update_attribute(:destination_y, 8)
      expect(piece.get_diagonal_path).to eq [[2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
    end

    it "should collect a list of coordinates when going south west" do
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:x, 8)
      piece.update_attribute(:y, 8)
      piece.update_attribute(:destination_x, 1)
      piece.update_attribute(:destination_y, 1)
      expect(piece.get_diagonal_path).to eq [[7, 7], [6, 6], [5, 5], [4, 4], [3, 3], [2, 2]]
    end
  end

  describe "path_clear? function" do
    it "should return false if any piece coordinates match any of the given path coordinates" do
      game = FactoryBot.create(:game)
      piece = FactoryBot.create(:piece)
      game.pieces.push(piece)
      expect(game.pieces.first.path_clear?([[5, 4], [5, 5], [5, 6]])).to eq false
    end

    it "should return true if no piece coordinates match any of the given path coordinates" do
      game = FactoryBot.create(:game)
      piece = FactoryBot.create(:piece)
      game.pieces.push(piece)
      expect(game.pieces.first.path_clear?([[1, 4], [1, 5], [1, 6]])).to eq true
    end
  end

  describe "horizontal_move? function" do
    it "should return true if the starting and ending coordinates are horizontal" do
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:destination_x, 8)
      piece.update_attribute(:destination_y, 5)
      expect(piece.horizontal_move?).to eq true
      piece.update_attribute(:destination_x, 2)
      piece.update_attribute(:destination_y, 5)
      expect(piece.horizontal_move?).to eq true
    end

    it "should return false if the starting and ending coordinates are not directly horizontal" do
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:destination_x, 8)
      piece.update_attribute(:destination_y, 7)
      expect(piece.horizontal_move?).to eq false
      piece.update_attribute(:destination_x, 2)
      piece.update_attribute(:destination_y, 3)
      expect(piece.horizontal_move?).to eq false
    end
  end

  describe "verticle_move? function" do
    it "should return true if the starting and ending coordinates are verticle" do
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:destination_x, 5)
      piece.update_attribute(:destination_y, 8)
      expect(piece.verticle_move?).to eq true
      piece.update_attribute(:destination_x, 5)
      piece.update_attribute(:destination_y, 2)
      expect(piece.verticle_move?).to eq true
    end

    it "should return false if the starting and ending coordinates are not directly verticle" do
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:destination_x, 7)
      piece.update_attribute(:destination_y, 8)
      expect(piece.verticle_move?).to eq false
      piece.update_attribute(:destination_x, 3)
      piece.update_attribute(:destination_y, 2)
      expect(piece.verticle_move?).to eq false
    end
  end

  describe "diagonal_move? function" do
    it "should return true if the starting and ending coordinates are diagonal" do
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:destination_x, 7)
      piece.update_attribute(:destination_y, 7)
      expect(piece.diagonal_move?).to eq true
      piece.update_attribute(:destination_x, 3)
      piece.update_attribute(:destination_y, 3)
      expect(piece.diagonal_move?).to eq true
      piece.update_attribute(:destination_x, 3)
      piece.update_attribute(:destination_y, 7)
      expect(piece.diagonal_move?).to eq true
      piece.update_attribute(:destination_x, 8)
      piece.update_attribute(:destination_y, 2)
      expect(piece.diagonal_move?).to eq true
    end

    it "should return false if the starting and ending coordinates are not diagonal" do
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:destination_x, 2)
      piece.update_attribute(:destination_y, 1)
      expect(piece.diagonal_move?).to eq false
      piece.update_attribute(:destination_x, 6)
      piece.update_attribute(:destination_y, 1)
      expect(piece.diagonal_move?).to eq false
      piece.update_attribute(:destination_x, 3)
      piece.update_attribute(:destination_y, 6)
      expect(piece.diagonal_move?).to eq false
      piece.update_attribute(:destination_x, 8)
      piece.update_attribute(:destination_y, 6)
      expect(piece.diagonal_move?).to eq false
    end
  end

  describe "king_move? function" do
    it "should return true if the ending coordinates directly border the king" do
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:destination_x, 5)
      piece.update_attribute(:destination_y, 4)
      expect(piece.king_move?).to eq true
      piece.update_attribute(:destination_x, 6)
      piece.update_attribute(:destination_y, 4)
      expect(piece.king_move?).to eq true
      piece.update_attribute(:destination_x, 6)
      piece.update_attribute(:destination_y, 5)
      expect(piece.king_move?).to eq true
      piece.update_attribute(:destination_x, 6)
      piece.update_attribute(:destination_y, 6)
      expect(piece.king_move?).to eq true
      piece.update_attribute(:destination_x, 5)
      piece.update_attribute(:destination_y, 6)
      expect(piece.king_move?).to eq true
      piece.update_attribute(:destination_x, 4)
      piece.update_attribute(:destination_y, 6)
      expect(piece.king_move?).to eq true
      piece.update_attribute(:destination_x, 4)
      piece.update_attribute(:destination_y, 5)
      expect(piece.king_move?).to eq true
      piece.update_attribute(:destination_x, 4)
      piece.update_attribute(:destination_y, 4)
      expect(piece.king_move?).to eq true
    end

    it "should not return true if the ending coordinates do not directly border the king" do
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:destination_x, 8)
      piece.update_attribute(:destination_y, 8)
      expect(piece.king_move?).not_to eq true
      piece.update_attribute(:destination_x, 1)
      piece.update_attribute(:destination_y, 1)
      expect(piece.king_move?).not_to eq true
      piece.update_attribute(:destination_x, 1)
      piece.update_attribute(:destination_y, 8)
      expect(piece.king_move?).not_to eq true
      piece.update_attribute(:destination_x, 8)
      piece.update_attribute(:destination_y, 1)
      expect(piece.king_move?).not_to eq true
      piece.update_attribute(:destination_x, 7)
      piece.update_attribute(:destination_y, 5)
      expect(piece.king_move?).not_to eq true
    end
  end

  describe "knight_move? function" do
    it "should return true if the move being requested is that of a knight" do
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:destination_x, 3)
      piece.update_attribute(:destination_y, 6)
      expect(piece.knight_move?).to eq true
      piece.update_attribute(:destination_x, 4)
      piece.update_attribute(:destination_y, 7)
      expect(piece.knight_move?).to eq true
      piece.update_attribute(:destination_x, 6)
      piece.update_attribute(:destination_y, 7)
      expect(piece.knight_move?).to eq true
      piece.update_attribute(:destination_x, 7)
      piece.update_attribute(:destination_y, 6)
      expect(piece.knight_move?).to eq true
      piece.update_attribute(:destination_x, 7)
      piece.update_attribute(:destination_y, 4)
      expect(piece.knight_move?).to eq true
      piece.update_attribute(:destination_x, 6)
      piece.update_attribute(:destination_y, 3)
      expect(piece.knight_move?).to eq true
      piece.update_attribute(:destination_x, 4)
      piece.update_attribute(:destination_y, 3)
      expect(piece.knight_move?).to eq true
      piece.update_attribute(:destination_x, 3)
      piece.update_attribute(:destination_y, 4)
      expect(piece.knight_move?).to eq true
    end

    it "should not return true if the move being requested is not that of a knight" do
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:destination_x, 8)
      piece.update_attribute(:destination_y, 8)
      expect(piece.knight_move?).not_to eq true
      piece.update_attribute(:destination_x, 1)
      piece.update_attribute(:destination_y, 1)
      expect(piece.knight_move?).not_to eq true
      piece.update_attribute(:destination_x, 6)
      piece.update_attribute(:destination_y, 5)
      expect(piece.knight_move?).not_to eq true
      piece.update_attribute(:destination_x, 8)
      piece.update_attribute(:destination_y, 1)
      expect(piece.knight_move?).not_to eq true
      piece.update_attribute(:destination_x, 1)
      piece.update_attribute(:destination_y, 8)
      expect(piece.knight_move?).not_to eq true
      piece.update_attribute(:destination_x, 2)
      piece.update_attribute(:destination_y, 3)
      expect(piece.knight_move?).not_to eq true
    end
  end

  describe "friendly_capture? function" do
    it "should return true if a piece's destination is occupied by a friendly piece" do
      game = FactoryBot.create(:game)
      game.pieces.create(x: 4, y: 4, color: "black")
      piece = FactoryBot.create(:piece)
      game.pieces.push(piece)
      expect(piece.friendly_capture?).to eq true
    end

    it "should return false if a piece's destination is occupied by an opposing piece" do
      game = FactoryBot.create(:game)
      game.pieces.create(x: 4, y: 4, color: "white")
      piece = FactoryBot.create(:piece)
      game.pieces.push(piece)
      expect(piece.friendly_capture?).to eq false
    end

    it "should return false if a piece's destination isn't occupied at all" do
      game = FactoryBot.create(:game)
      piece = FactoryBot.create(:piece)
      game.pieces.push(piece)
      expect(piece.friendly_capture?).to eq false
    end
  end

  describe "forward_pawn_move? function" do
    it "should return true if the piece advances by one tile" do
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:destination_x, 5)
      piece.update_attribute(:destination_y, 6)
      expect(piece.forward_pawn_move?(:+)).to eq true
    end

    it "should return nil if the piece doesn't advance forward by just one tile" do
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:destination_x, 5)
      piece.update_attribute(:destination_y, 3)
      expect(piece.forward_pawn_move?(:-)).to eq nil
      piece.update_attribute(:destination_x, 1)
      piece.update_attribute(:destination_y, 1)
      expect(piece.forward_pawn_move?(:-)).to eq nil
      piece.update_attribute(:destination_x, 8)
      piece.update_attribute(:destination_y, 8)
      expect(piece.forward_pawn_move?(:-)).to eq nil
      piece.update_attribute(:destination_x, 5)
      piece.update_attribute(:destination_y, 6)
      expect(piece.forward_pawn_move?(:-)).to eq nil
    end

    it "should return false if there is a piece in the way" do
      game = FactoryBot.create(:game)
      game.pieces.create(x: 5, y: 6)
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:destination_x, 5)
      piece.update_attribute(:destination_y, 6)
      game.pieces.push(piece)
      expect(piece.forward_pawn_move?(:+)).to eq false
    end
  end

  describe "double_jump? function" do
    it "should return true if the piece advances by two tiles from the starting point" do
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:x, 1)
      piece.update_attribute(:y, 7)
      piece.update_attribute(:destination_x, 1)
      piece.update_attribute(:destination_y, 5)
      expect(piece.double_jump?(:-, 7)).to eq true
    end

    it "should return false if there is a piece directly in the way" do
      game = FactoryBot.create(:game)
      game.pieces.create(x: 1, y: 6)
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:x, 1)
      piece.update_attribute(:y, 7)
      piece.update_attribute(:destination_x, 1)
      piece.update_attribute(:destination_y, 5)
      game.pieces.push(piece)
      expect(piece.double_jump?(:-, 7)).to eq false
    end

    it "should return false if there is a piece at the destination" do
      game = FactoryBot.create(:game)
      game.pieces.create(x: 1, y: 5)
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:x, 1)
      piece.update_attribute(:y, 7)
      piece.update_attribute(:destination_x, 1)
      piece.update_attribute(:destination_y, 5)
      game.pieces.push(piece)
      expect(piece.double_jump?(:-, 7)).to eq false
    end

    it "should return nil if the piece isn't trying to move forward by two tiles" do
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:x, 1)
      piece.update_attribute(:y, 2)
      piece.update_attribute(:destination_x, 1)
      piece.update_attribute(:destination_y, 5)
      expect(piece.double_jump?(:+, 2)).to eq nil
      piece.update_attribute(:destination_x, 1)
      piece.update_attribute(:destination_y, 1)
      expect(piece.double_jump?(:+, 2)).to eq nil
      piece.update_attribute(:destination_x, 8)
      piece.update_attribute(:destination_y, 8)
      expect(piece.double_jump?(:+, 2)).to eq nil
      piece.update_attribute(:destination_x, 1)
      piece.update_attribute(:destination_y, 8)
      expect(piece.double_jump?(:+, 2)).to eq nil
      piece.update_attribute(:destination_x, 4)
      piece.update_attribute(:destination_y, 4)
      expect(piece.double_jump?(:+, 2)).to eq nil
    end
  end

  describe "pawn_capturing? function" do
    it "should return true if the piece goes for a capture to it's right" do
      game = FactoryBot.create(:game)
      game.pieces.create(x: 6, y: 6)
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:destination_x, 6)
      piece.update_attribute(:destination_y, 6)
      game.pieces.push(piece)
      expect(piece.pawn_capturing?(:+)).to eq true
    end

    it "should return true if the piece goes for a capture to it's left" do
      game = FactoryBot.create(:game)
      game.pieces.create(x: 4, y: 4)
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:destination_x, 4)
      piece.update_attribute(:destination_y, 4)
      game.pieces.push(piece)
      expect(piece.pawn_capturing?(:-)).to eq true
    end

    it "should return false if the piece goes for a capture to it's left, but there's no piece to capture" do
      game = FactoryBot.create(:game)
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:destination_x, 4)
      piece.update_attribute(:destination_y, 6)
      game.pieces.push(piece)
      expect(piece.pawn_capturing?(:+)).to eq false
    end

    it "should return false if the piece goes for a capture to it's right, but there's no piece to capture" do
      game = FactoryBot.create(:game)
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:destination_x, 6)
      piece.update_attribute(:destination_y, 4)
      game.pieces.push(piece)
      expect(piece.pawn_capturing?(:-)).to eq false
    end

    it "should return nil if the piece goes for a capture that's not directly to it's left or right" do
      game = FactoryBot.create(:game)
      piece = FactoryBot.create(:piece)
      game.pieces.push(piece)
      game.pieces.create(x: 8, y: 8)
      piece.update_attribute(:destination_x, 8)
      piece.update_attribute(:destination_y, 8)
      expect(piece.pawn_capturing?(:-)).to eq nil
      game.pieces.create(x: 1, y: 1)
      piece.update_attribute(:destination_x, 1)
      piece.update_attribute(:destination_y, 1)
      expect(piece.pawn_capturing?(:-)).to eq nil
      game.pieces.create(x: 1, y: 8)
      piece.update_attribute(:destination_x, 1)
      piece.update_attribute(:destination_y, 8)
      expect(piece.pawn_capturing?(:-)).to eq nil
    end
  end

  describe "tile_has_piece? function" do
    it "should return true if a given tile is occupied" do
      piece = FactoryBot.create(:piece)
      game = FactoryBot.create(:game)
      game.pieces.push(piece)
      expect(piece.tile_has_piece?(5, 5)).to eq true
    end

    it "should return false if a given tile is not occupied" do
      piece = FactoryBot.create(:piece)
      game = FactoryBot.create(:game)
      game.pieces.push(piece)
      expect(piece.tile_has_piece?(3, 3)).to eq false
    end
  end

  describe "promoted? function" do
    it "should return true if a given piece type isn't equal to a piece's type" do
      piece = FactoryBot.create(:piece)
      expect(piece.promoted?("pawn")).to eq true
    end

    it "should return false if a given piece type is equal to a piece's type" do
      piece = FactoryBot.create(:piece)
      piece.update_attribute(:piece_type, "pawn")
      expect(piece.promoted?("pawn")).to eq false
    end
  end
end
