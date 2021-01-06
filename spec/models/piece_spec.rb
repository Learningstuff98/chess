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
end
