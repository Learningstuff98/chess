require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  describe "update action" do
    it "should allow for updates" do
      piece = FactoryBot.create(:piece)
      user = FactoryBot.create(:user)
      sign_in user
      post :update, params: {
        id: piece.id,
        piece: {
          destination_x: 4,
          destination_y: 4
        }
      }
      piece.reload
      expect(piece.destination_x).to eq 4
      expect(piece.destination_y).to eq 4
    end
  end
end
