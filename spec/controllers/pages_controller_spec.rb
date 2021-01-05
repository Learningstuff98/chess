require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "home action" do
    it "should load the page" do
      get :home
      expect(response).to have_http_status(:success)
    end
  end
end
