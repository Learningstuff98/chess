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

  describe "pawn_capturing? function" do
    it "should return true if the piece goes for a capture to it's right" do
      game = FactoryBot.create(:game)
      game.pieces.create(x: 6, y: 6)
      expect(PawnMovementProfile.pawn_capturing?(6, 6, 5, 5, :+, game)).to eq true
    end

    it "should return true if the piece goes for a capture to it's left" do
      game = FactoryBot.create(:game)
      game.pieces.create(x: 4, y: 4)
      expect(PawnMovementProfile.pawn_capturing?(4, 4, 5, 5, :-, game)).to eq true
    end

    it "should return false if the piece goes for a capture to it's left, but there's no piece to capture" do
      game = FactoryBot.create(:game)
      expect(PawnMovementProfile.pawn_capturing?(6, 6, 5, 5, :+, game)).to eq false
    end

    it "should return false if the piece goes for a capture to it's right, but there's no piece to capture" do
      game = FactoryBot.create(:game)
      expect(PawnMovementProfile.pawn_capturing?(6, 4, 5, 5, :-, game)).to eq false
    end

    it "shouldn't return true if the piece tries to make a capture that's not directly forward and to either side", :aggregate_failures do
      game = FactoryBot.create(:game)
      game.pieces.create(x: 8, y: 8)
      expect(PawnMovementProfile.pawn_capturing?(8, 8, 5, 5, :-, game)).not_to eq true
      game.pieces.first.update(x: 1, y: 1)
      expect(PawnMovementProfile.pawn_capturing?(1, 1, 5, 5, :+, game)).not_to eq true
      game.pieces.first.update(x: 1, y: 8)
      expect(PawnMovementProfile.pawn_capturing?(1, 8, 5, 5, :+, game)).not_to eq true
      game.pieces.first.update(x: 8, y: 1)
      expect(PawnMovementProfile.pawn_capturing?(8, 1, 5, 5, :+, game)).not_to eq true
      game.pieces.first.update(x: 4, y: 3)
      expect(PawnMovementProfile.pawn_capturing?(4, 3, 5, 5, :-, game)).not_to eq true
    end
  end

  describe "double_jump? function" do
    it "should return true if the piece wants to advance by two tiles from the starting point" do
      game = FactoryBot.create(:game)
      expect(PawnMovementProfile.double_jump?(1, 5, 1, 7, :-, 7, game)).to eq true
    end

    it "should return false if there is a piece directly in the way" do
      game = FactoryBot.create(:game)
      game.pieces.create(x: 1, y: 6)
      expect(PawnMovementProfile.double_jump?(1, 5, 1, 7, :-, 7, game)).to eq false
    end

    it "should return false if there is a piece at the destination" do
      game = FactoryBot.create(:game)
      game.pieces.create(x: 1, y: 5)
      expect(PawnMovementProfile.double_jump?(1, 5, 1, 7, :-, 7, game)).to eq false
    end

    it "should not return true if the piece isn't trying to move forward by two tiles", :aggregate_failures do
      game = FactoryBot.create(:game)
      expect(PawnMovementProfile.double_jump?(1, 5, 1, 2, :+, 2, game)).not_to eq true
      expect(PawnMovementProfile.double_jump?(1, 1, 1, 2, :+, 2, game)).not_to eq true
      expect(PawnMovementProfile.double_jump?(8, 8, 1, 2, :+, 2, game)).not_to eq true
      expect(PawnMovementProfile.double_jump?(1, 8, 1, 2, :+, 2, game)).not_to eq true
      expect(PawnMovementProfile.double_jump?(4, 4, 1, 2, :+, 2, game)).not_to eq true
    end
  end
end
