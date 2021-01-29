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

  describe "get_host_color function" do
    it "should return white if the game is being hosted as white" do
      game = FactoryBot.create(:game)
      game.update_attribute(:host_as_white, true)
      expect(game.get_host_color).to eq "white"
    end

    it "should return black if the game is not being hosted as white" do
      game = FactoryBot.create(:game)
      game.update_attribute(:host_as_white, false)
      expect(game.get_host_color).to eq "black"
    end
  end

  describe "create_lobby_token function" do
    it "should create a lobby token for a game" do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game)
      game.update_attribute(:host_as_white, true)
      game.create_lobby_token(user)
      expect(LobbyToken.all.count).to eq 1
      expect(LobbyToken.all.last.game_id).to eq game.id
      expect(LobbyToken.all.last.host_username).to eq user.username
      expect(LobbyToken.all.last.host_color).to eq "white"
    end
  end

  describe "manage_token function" do
    it "should delete the game's lobby token if the game is full" do
      game = FactoryBot.create(:game)
      lobby_token = FactoryBot.create(:lobby_token)
      game.lobby_tokens.push(lobby_token)
      game.update_attribute(:as_white, "a_username")
      game.update_attribute(:as_black, "a_username")
      game.manage_token
      expect(LobbyToken.all.count).to eq 0
    end

    it "should not delete the game's lobby token if the game isn't full" do
      game = FactoryBot.create(:game)
      lobby_token = FactoryBot.create(:lobby_token)
      game.lobby_tokens.push(lobby_token)

      game.update_attribute(:as_white, "a_username")
      game.update_attribute(:as_black, nil)
      game.manage_token
      expect(LobbyToken.all.count).to eq 1

      game.update_attribute(:as_white, nil)
      game.update_attribute(:as_black, "a_username")
      game.manage_token
      expect(LobbyToken.all.count).to eq 1
    end
  end

  describe "victory? function" do
    it "should set white as the winner if the black king is captured" do
      game = FactoryBot.create(:game)
      game.pieces.create(
        piece_type: "king",
        color: "black",
        in_play: false
      )
      game.update_attribute(:as_white, "a_username")
      game.victory?
      expect(game.winner_username).to eq "a_username"
    end

    it "should set black as the winner if the white king is captured" do
      game = FactoryBot.create(:game)
      game.pieces.create(
        piece_type: "king",
        color: "white",
        in_play: false
      )
      game.update_attribute(:as_black, "a_username")
      game.victory?
      expect(game.winner_username).to eq "a_username"
    end

    it "should not set either player as the winner if no kings are captured" do
      game = FactoryBot.create(:game)
      game.pieces.create(
        piece_type: "king",
        color: "white",
        in_play: true
      )
      game.pieces.create(
        piece_type: "king",
        color: "black",
        in_play: true
      )
      game.update_attribute(:as_white, "a_username")
      game.update_attribute(:as_black, "a_username2")
      game.victory?
      expect(game.winner_username).to eq nil
    end
  end
end
