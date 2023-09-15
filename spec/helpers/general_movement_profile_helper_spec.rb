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

  describe "verticle_move? function" do
    it "should return true if the starting and ending coordinates are verticle", :aggregate_failures do
      expect(GeneralMovementProfile.verticle_move?(5, 5, 5, 1)).to eq true
      expect(GeneralMovementProfile.verticle_move?(5, 5, 5, 8)).to eq true
    end

    it "should return false if the starting and ending coordinates are not verticle", :aggregate_failures do
      expect(GeneralMovementProfile.verticle_move?(5, 5, 8, 8)).to eq false
      expect(GeneralMovementProfile.verticle_move?(5, 5, 1, 1)).to eq false
    end
  end

  describe "diagonal_move? function" do
    it "should return true if the starting and ending coordinates are diagonal", :aggregate_failures do
      expect(GeneralMovementProfile.diagonal_move?(5, 5, 7, 7)).to eq true
      expect(GeneralMovementProfile.diagonal_move?(5, 5, 3, 3)).to eq true
      expect(GeneralMovementProfile.diagonal_move?(5, 5, 3, 7)).to eq true
      expect(GeneralMovementProfile.diagonal_move?(5, 5, 8, 2)).to eq true
    end

    it "should return false if the starting and ending coordinates are not diagonal", :aggregate_failures do
      expect(GeneralMovementProfile.diagonal_move?(5, 5, 2, 1)).to eq false
      expect(GeneralMovementProfile.diagonal_move?(5, 5, 6, 1)).to eq false
      expect(GeneralMovementProfile.diagonal_move?(5, 5, 3, 6)).to eq false
      expect(GeneralMovementProfile.diagonal_move?(5, 5, 8, 6)).to eq false
    end
  end
end
