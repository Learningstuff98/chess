require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "pages#home" do
    it "should load the page" do
      get root_path
      expect(response).to be_successful
    end
  end

  describe "pages#lobby" do
    it "should authenticate the user" do
      get lobby_path
      expect(response).to redirect_to new_user_session_path
    end

    it "should load the page" do
      user = FactoryBot.create(:user)
      sign_in user
      get lobby_path
      expect(response).to be_successful
    end
  end
end
