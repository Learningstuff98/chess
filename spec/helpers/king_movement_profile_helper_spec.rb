require 'rails_helper'

RSpec.describe KingMovementProfile, type: :helper do
  describe "king_move? function" do
    it "should return true if the destination coordinates directly border the king", :aggregate_failures do
      expect(KingMovementProfile.king_move?(5, 4, 5, 5)).to eq true
      expect(KingMovementProfile.king_move?(6, 4, 5, 5)).to eq true
      expect(KingMovementProfile.king_move?(6, 5, 5, 5)).to eq true
      expect(KingMovementProfile.king_move?(6, 6, 5, 5)).to eq true
      expect(KingMovementProfile.king_move?(5, 6, 5, 5)).to eq true
      expect(KingMovementProfile.king_move?(4, 6, 5, 5)).to eq true
      expect(KingMovementProfile.king_move?(4, 5, 5, 5)).to eq true
      expect(KingMovementProfile.king_move?(4, 4, 5, 5)).to eq true
    end

    it "should not return true if the destination coordinates do not border the king", :aggregate_failures do
      expect(KingMovementProfile.king_move?(8, 8, 5, 5)).not_to eq true
      expect(KingMovementProfile.king_move?(1, 1, 5, 5)).not_to eq true
      expect(KingMovementProfile.king_move?(1, 8, 5, 5)).not_to eq true
      expect(KingMovementProfile.king_move?(8, 1, 5, 5)).not_to eq true
      expect(KingMovementProfile.king_move?(7, 5, 5, 5)).not_to eq true
    end
  end
end
