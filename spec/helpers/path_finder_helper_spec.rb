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
end
