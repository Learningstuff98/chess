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
      expect(piece.get_horizontal_or_verticle_path).to eq [[2, 4], [3, 4], [4, 4], [5, 4], [6, 4], [7, 4]]
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
      expect(piece.get_horizontal_or_verticle_path).to eq [[1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7]]
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
end
