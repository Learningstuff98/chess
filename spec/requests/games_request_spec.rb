require 'rails_helper'

RSpec.describe "Games", type: :request do
  context "while logged in" do
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
    end

    describe "games#new" do
      it "should load the page" do
        get new_game_path
        expect(response).to be_successful
      end
    end

    describe "games#create" do
      it "should let users start games", :aggregate_failures do
        post games_path(
          {
            game: {
              host_as_white: true
            }
          }
        )
        expect(response).to have_http_status(:found)
        expect(@user.games.count).to eq 1
        expect(@user.games.first.pieces.count).to eq 32
        expect(@user.games.first.as_white).to eq @user.username
      end
    end

    describe "games#show" do
      it "should successfully load the page " do
        game = FactoryBot.create(:game)
        get game_path(game)
        expect(response).to be_successful
      end
    end

    describe "games#destroy" do
      it "should let users end matches", :aggregate_failures do
        game = FactoryBot.create(:game)
        game.make_pieces
        game.comments.create(content: "Hello World", username: @user.username)
        delete game_path(game)
        expect(response).to have_http_status(:found)
        expect(Game.count).to eq 0
        expect(Piece.count).to eq 0
        expect(Comment.count).to eq 0
      end
    end
  end
end
