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
end
