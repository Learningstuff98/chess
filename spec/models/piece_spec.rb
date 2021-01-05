require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "update_x_and_y function" do
    it "should update the x and y attributes" do
      piece = FactoryBot.create(:piece)
      piece.update_x_and_y(4, 4)
      expect(piece.x).to eq 4
      expect(piece.y).to eq 4
    end
  end
end
