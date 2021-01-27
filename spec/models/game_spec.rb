require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "make_piece function" do
    it "should create a chess piece" do
      game = FactoryBot.create(:game)
      game.make_piece("queen", "black", 4, 8, "♛")
      expect(Piece.all.count).to eq 1
    end
  end

  describe "make_pieces function" do
    it "should make 32 chess pieces" do
      game = FactoryBot.create(:game)
      game.make_pieces
      expect(Piece.all.count).to eq 32
    end
  end

  describe "assign_host function" do
    it "should assign the game's user as white if host_as_white is true" do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game)
      game.update_attribute(:host_as_white, true)
      game.assign_host(user)
      expect(game.as_white).to eq user.username
      expect(game.as_black).to eq nil
    end

    it "should assign the game's user as black if host_as_white is false" do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game)
      game.update_attribute(:host_as_white, false)
      game.assign_host(user)
      expect(game.as_white).to eq nil
      expect(game.as_black).to eq user.username
    end
  end

  describe "assign_guest function" do
    it "should assign a guest as black if as_black is not assigned" do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game)
      game.update_attribute(:as_white, "host_username")
      game.assign_guest(user)
      expect(game.as_white).to eq "host_username"
      expect(game.as_black).to eq user.username
    end

    it "should assign a guest as white if as_white is not assigned" do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game)
      game.update_attribute(:as_black, "host_username")
      game.assign_guest(user)
      expect(game.as_white).to eq user.username
      expect(game.as_black).to eq "host_username"
    end

    it "should do nothing if the user is the host" do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game)
      game.update_attribute(:user_id, user.id)
      game.update_attribute(:as_white, user.username)
      game.assign_guest(user)
      expect(game.as_white).to eq user.username
      expect(game.as_black).to eq nil
    end
  end

  describe "handle_open_status function" do
    it "should set the open status to false if there are two players" do
      game = FactoryBot.create(:game)
      game.update_attribute(:as_white, "player_1")
      game.update_attribute(:as_black, "player_2")
      game.handle_open_status
      expect(game.open).to eq false
    end

    it "should keep the open status set to true if there is one player" do
      game = FactoryBot.create(:game)
      game.update_attribute(:as_white, "player_1")
      game.handle_open_status
      expect(game.open).to eq true
    end
  end
end
