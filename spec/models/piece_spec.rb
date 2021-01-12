require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "update_x_and_y function" do
    it "should update the x and y attributes" do
      piece = FactoryBot.create(:piece)
      piece.update_x_and_y(4, 4)
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
end
