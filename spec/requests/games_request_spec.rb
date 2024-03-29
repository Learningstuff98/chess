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
      it "should successfully load the page" do
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

  context "while logged in as a different user then the game host" do
    before do
      user = FactoryBot.create(:user)
      @game = user.games.create(host_as_white: true)
      @game.assign_host(user)
      @guest = FactoryBot.create(:user)
      sign_in @guest
    end

    describe "games#show" do
      it "loads successfully and assigns the guest to the remaining color option", :aggregate_failures do
        get game_path(@game)
        expect(response).to be_successful
        @game.reload
        expect(@game.as_black).to eq @guest.username
      end
    end
  end

  context "while not logged in" do
    describe "games#new" do
      it "should redirect to the log in page" do
        get new_game_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "games#create" do
      it "should redirect to the log in page", :aggregate_failures do
        post games_path(
          {
            game: {
              host_as_white: true
            }
          }
        )
        expect(response).to redirect_to new_user_session_path
        expect(Game.count).to eq 0
      end
    end

    describe "games#show" do
      it "should redirect to the log in page" do
        game = FactoryBot.create(:game)
        get game_path(game)
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "games#destroy" do
      it "should redirect to the log in page", :aggregate_failures do
        game = FactoryBot.create(:game)
        delete game_path(game)
        expect(response).to redirect_to new_user_session_path
        expect(Game.count).to eq 1
      end
    end
  end
end
