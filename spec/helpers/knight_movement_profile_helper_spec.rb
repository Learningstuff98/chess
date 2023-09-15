require 'rails_helper'

RSpec.describe KnightMovementProfile, type: :helper do
  describe "knight_move? function" do
    it "should return true if the move being requested is that of a knight", :aggregate_failures do
      expect(KnightMovementProfile.knight_move?(3, 6, 5, 5)).to eq true
      expect(KnightMovementProfile.knight_move?(4, 7, 5, 5)).to eq true
      expect(KnightMovementProfile.knight_move?(6, 7, 5, 5)).to eq true
      expect(KnightMovementProfile.knight_move?(7, 6, 5, 5)).to eq true
      expect(KnightMovementProfile.knight_move?(7, 4, 5, 5)).to eq true
      expect(KnightMovementProfile.knight_move?(6, 3, 5, 5)).to eq true
      expect(KnightMovementProfile.knight_move?(4, 3, 5, 5)).to eq true
      expect(KnightMovementProfile.knight_move?(3, 4, 5, 5)).to eq true
    end

    it "should not return true if the move being requested is not that of a knight", :aggregate_failures do
      expect(KnightMovementProfile.knight_move?(8, 8, 5, 5)).not_to eq true
      expect(KnightMovementProfile.knight_move?(1, 1, 5, 5)).not_to eq true
      expect(KnightMovementProfile.knight_move?(6, 5, 5, 5)).not_to eq true
      expect(KnightMovementProfile.knight_move?(8, 1, 5, 5)).not_to eq true
      expect(KnightMovementProfile.knight_move?(1, 8, 5, 5)).not_to eq true
      expect(KnightMovementProfile.knight_move?(2, 3, 5, 5)).not_to eq true
    end
  end
end
