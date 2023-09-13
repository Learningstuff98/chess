require 'rails_helper'

RSpec.describe GeneralMovementProfile, type: :helper do
  describe "horizontal_move? function" do
    it "should return true if the starting and ending coordinates are horizontal", :aggregate_failures do
      expect(GeneralMovementProfile.horizontal_move?(5, 5, 8, 5)).to eq true
      expect(GeneralMovementProfile.horizontal_move?(5, 5, 2, 5)).to eq true
    end

    it "should return false if the starting and ending coordinates are not horizontal", :aggregate_failures do
      expect(GeneralMovementProfile.horizontal_move?(5, 5, 6, 6)).to eq false
      expect(GeneralMovementProfile.horizontal_move?(5, 5, 5, 1)).to eq false
    end
  end
end
