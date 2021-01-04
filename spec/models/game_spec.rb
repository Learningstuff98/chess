require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "make_piece function" do
    it "should create a chess piece" do
      game = FactoryBot.create(:game)
      game.make_piece("queen", "black", 4, 8, "♛")
      expect(Piece.all.count).to eq 1
    end
  end

  describe "make_pieces function" do
    it "should make 32 chess pieces" do
      game = FactoryBot.create(:game)
      game.make_pieces
      expect(Piece.all.count).to eq 32
    end
  end
end
