require 'rails_helper'

RSpec.describe PathFinder, type: :helper do
  describe "range function" do
    it "given two values, returns an array of values that fills the gap between (not including) the inputs", :aggregate_failures do
      expect(PathFinder.range(1, 8)).to eq [2, 3, 4, 5, 6, 7]
      expect(PathFinder.range(8, 1)).to eq [2, 3, 4, 5, 6, 7]
      expect(PathFinder.range(8, 7)).to eq []
      expect(PathFinder.range(5, 3)).to eq [4]
      expect(PathFinder.range(7, 3)).to eq [4, 5, 6]
    end
  end

  describe "horizontal_path function" do
    it "returns an array of horizontal coordinates that fills the gap between (not including) the x inputs", :aggregate_failures do
      expect(PathFinder.horizontal_path(1, 2, 8).length).to eq 6
      [[2, 2], [3, 2], [4, 2], [5, 2], [6, 2], [7, 2]].each do |coordinates|
        expect(PathFinder.horizontal_path(1, 2, 8).include?(coordinates)).to eq true
      end
    end
  end

  describe "vertical_path function" do
    it "returns an array of verticle coordinates that fills the gap between (not including) the y inputs", :aggregate_failures do
      expect(PathFinder.verticle_path(1, 1, 8).length).to eq 6
      [[1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7]].each do |coordinates|
        expect(PathFinder.verticle_path(1, 1, 8).include?(coordinates)).to eq true
      end
    end
  end

  describe "diagonal_path function" do
    it "returns an array of diagonal coordinates that fills the gap between (not including) the inputs", :aggregate_failures do
      expect(PathFinder.diagonal_path(1, 1, 8, 8).length).to eq 6
      [[2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]].each do |coordinates|
        expect(PathFinder.diagonal_path(1, 1, 8, 8).include?(coordinates)).to eq true
      end

      expect(PathFinder.diagonal_path(8, 8, 1, 1).length).to eq 6
      [[2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]].each do |coordinates|
        expect(PathFinder.diagonal_path(8, 8, 1, 1).include?(coordinates)).to eq true
      end

      expect(PathFinder.diagonal_path(1, 8, 8, 1).length).to eq 6
      [[2, 7], [3, 6], [4, 5], [5, 4], [6, 3], [7, 2]].each do |coordinates|
        expect(PathFinder.diagonal_path(1, 8, 8, 1).include?(coordinates)).to eq true
      end

      expect(PathFinder.diagonal_path(8, 1, 1, 8).length).to eq 6
      [[2, 7], [3, 6], [4, 5], [5, 4], [6, 3], [7, 2]].each do |coordinates|
        expect(PathFinder.diagonal_path(8, 1, 1, 8).include?(coordinates)).to eq true
      end

      expect(PathFinder.diagonal_path(7, 1, 4, 4).length).to eq 2
      [[6, 2], [5, 3]].each do |coordinates|
        expect(PathFinder.diagonal_path(7, 1, 4, 4).include?(coordinates)).to eq true
      end

      expect(PathFinder.diagonal_path(6, 8, 8, 6)).to eq [[7, 7]]
    end
  end

  describe "diagonal_y_values function" do
    it "returns a list of y values in the correct order", :aggregate_failures do
      expect(PathFinder.diagonal_y_values(1, 1, 8, 8)).to eq [2, 3, 4, 5, 6, 7]
      expect(PathFinder.diagonal_y_values(8, 8, 1, 1)).to eq [2, 3, 4, 5, 6, 7]
      expect(PathFinder.diagonal_y_values(1, 8, 8, 1)).to eq [7, 6, 5, 4, 3, 2]
      expect(PathFinder.diagonal_y_values(8, 1, 1, 8)).to eq [7, 6, 5, 4, 3, 2]
    end
  end

  describe "path_clear? function" do
    it "should return false if any piece coordinates match any of the given path coordinates" do
      game = FactoryBot.create(:game)
      FactoryBot.create(:piece, game_id: game.id)
      piece = FactoryBot.create(:piece, game_id: game.id, x: 5, y: 3)
      expect(PathFinder.path_clear?([[5, 4], [5, 5], [5, 6]], game, piece)).to eq false
    end

    it "should return true if no piece coordinates match any of the given path coordinates" do
      game = FactoryBot.create(:game)
      FactoryBot.create(:piece, game_id: game.id)
      piece = FactoryBot.create(:piece, game_id: game.id, x: 5, y: 3)
      expect(PathFinder.path_clear?([[1, 4], [1, 5], [1, 6]], game, piece)).to eq true
    end
  end
end
