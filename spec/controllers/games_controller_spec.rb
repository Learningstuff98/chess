require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe "new action" do
    it "should authenticate the user" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it "should let users get to the new game page" do
      user = FactoryBot.create(:user)
      sign_in user
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "create action" do
    it "should authenticate the user" do
      post :create
      expect(response).to redirect_to new_user_session_path
    end

    it "should let users start games" do
      user = FactoryBot.create(:user)
      sign_in user
      post :create, params: {
        user_id: user.id,
        game: { host_as_white: false }
      }
      expect(response).to have_http_status(:found)
      expect(Game.all.count).to eq 1
      expect(Game.all.last.host_as_white).to eq false
    end
  end

  describe "show action" do
    it "should authenticate the user" do
      game = FactoryBot.create(:game)
      get :show, params: { id: game.id }
      expect(response).to redirect_to new_user_session_path
    end

    it "should load the page" do
      user = FactoryBot.create(:user)
      sign_in user
      game = FactoryBot.create(:game)
      get :show, params: { id: game.id }
      expect(response).to have_http_status(:success)
    end
  end
end
