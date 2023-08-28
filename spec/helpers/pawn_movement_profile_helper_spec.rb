require 'rails_helper'

RSpec.describe PawnMovementProfile, type: :helper do
  describe "tile_has_piece? function" do
    it "should return true if a given tile is occupied" do
      game = FactoryBot.create(:game)
      FactoryBot.create(:piece, game_id: game.id)
      expect(PawnMovementProfile.tile_has_piece?(5, 5, game)).to eq true
    end

    it "should return false if a given tile is not occupied" do
      game = FactoryBot.create(:game)
      FactoryBot.create(:piece, game_id: game.id)
      expect(PawnMovementProfile.tile_has_piece?(3, 3, game)).to eq false
    end
  end

  describe "forward_pawn_move? function" do
    it "should return true if the piece wants to advance by one tile", :aggregate_failures do
      game = FactoryBot.create(:game)
      expect(PawnMovementProfile.forward_pawn_move?(5, 6, 5, 5, :+, game)).to eq true
      expect(PawnMovementProfile.forward_pawn_move?(5, 4, 5, 5, :-, game)).to eq true
    end

    it "should not return true if the piece doesn't want to advance forward by just one tile", :aggregate_failures do
      game = FactoryBot.create(:game)
      expect(PawnMovementProfile.forward_pawn_move?(5, 3, 5, 5, :-, game)).not_to eq true
      expect(PawnMovementProfile.forward_pawn_move?(1, 1, 5, 5, :-, game)).not_to eq true
      expect(PawnMovementProfile.forward_pawn_move?(8, 8, 5, 5, :+, game)).not_to eq true
      expect(PawnMovementProfile.forward_pawn_move?(5, 6, 5, 5, :-, game)).not_to eq true
    end

    it "should not return true if there is a piece in the way", :aggregate_failures do
      game = FactoryBot.create(:game)
      game.pieces.create(x: 5, y: 6)
      expect(PawnMovementProfile.forward_pawn_move?(5, 6, 5, 5, :+, game)).not_to eq true
      game.pieces.first.update(x: 5, y: 4)
      expect(PawnMovementProfile.forward_pawn_move?(5, 4, 5, 5, :-, game)).not_to eq true
    end
  end
end
