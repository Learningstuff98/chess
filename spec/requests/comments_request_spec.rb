require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe "comments#create" do
    it "should authenticate the user", :aggregate_failures do
      game = FactoryBot.create(:game)
      post game_comments_path(
        {
          game_id: game.id,
          comment: {
            content: "Hello World"
          }
        }
      )
      expect(response).to redirect_to new_user_session_path
      expect(Comment.count).to eq 0
    end

    it "should let users make comments", :aggregate_failures do
      user = FactoryBot.create(:user)
      sign_in user
      game = FactoryBot.create(:game)
      post game_comments_path(
        {
          game_id: game.id,
          comment: {
            content: "Hello World"
          }
        }
      )
      expect(response).to be_successful
      expect(Comment.count).to eq 1
      expect(Comment.first.content).to eq "Hello World"
      expect(Comment.first.username).to eq user.username
    end
  end
end
