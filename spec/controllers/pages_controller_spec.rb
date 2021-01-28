require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "home action" do
    it "should load the page" do
      get :home
      expect(response).to have_http_status(:success)
    end
  end

  describe "lobby action" do
    it "should authenticate the user" do
      get :lobby
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully load the page" do
      user = FactoryBot.create(:user)
      sign_in user
      get :lobby
      expect(response).to have_http_status(:success)
    end
  end
end
