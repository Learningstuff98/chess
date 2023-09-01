require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "update_x_and_y function" do
    it "should update the x and y attributes", :aggregate_failures do
      piece = FactoryBot.create(:piece)
      piece.update_x_and_y
      expect(piece.x).to eq 4
      expect(piece.y).to eq 4
    end
  end

  describe "capture_piece function" do
    it "should remove any pieces that have matching coordinates from play", :aggregate_failures do
      game = FactoryBot.create(:game)
      first_piece = game.pieces.create(x: 1, y: 2)
      second_piece = game.pieces.create(x: 1, y: 2)
      second_piece.capture_piece
      expect(first_piece.in_play).to eq false
      expect(first_piece.x).to eq 100
    end

    it "should only capture pieces with matching coordinates", :aggregate_failures do
      game = FactoryBot.create(:game)
      first_piece = game.pieces.create(x: 1, y: 2)
      second_piece = game.pieces.create(x: 5, y: 5)
      second_piece.capture_piece
      expect(first_piece.in_play).to eq true
      expect(first_piece.x).to eq 1
    end

    it "should not capture itself", :aggregate_failures do
      FactoryBot.create(:game)
      piece = FactoryBot.create(:piece)
      piece.capture_piece
      expect(piece.in_play).to eq true
      expect(piece.x).to eq 5
    end
  end

  describe "horizontal_or_verticle_path function" do
    it "should collect a list of coordinates when going left to right", :aggregate_failures do
      piece = FactoryBot.create(:piece)
      piece.update(x: 1)
      piece.update(y: 4)
      piece.update(destination_x: 8)
      piece.update(destination_y: 4)
      coordinates = piece.horizontal_or_verticle_path
      expect(coordinates.length).to eq 6
      expect(coordinates.include?([2, 4])).to eq true
      expect(coordinates.include?([3, 4])).to eq true
      expect(coordinates.include?([4, 4])).to eq true
      expect(coordinates.include?([5, 4])).to eq true
      expect(coordinates.include?([6, 4])).to eq true
      expect(coordinates.include?([7, 4])).to eq true
    end

    it "should collect a list of coordinates when going right to left", :aggregate_failures do
      piece = FactoryBot.create(:piece)
      piece.update(x: 8)
      piece.update(y: 4)
      piece.update(destination_x: 1)
      piece.update(destination_y: 4)
      coordinates = piece.horizontal_or_verticle_path
      expect(coordinates.length).to eq 6
      expect(coordinates.include?([7, 4])).to eq true
      expect(coordinates.include?([6, 4])).to eq true
      expect(coordinates.include?([5, 4])).to eq true
      expect(coordinates.include?([4, 4])).to eq true
      expect(coordinates.include?([3, 4])).to eq true
      expect(coordinates.include?([2, 4])).to eq true
    end

    it "should collect a list of coordinates when going upwards", :aggregate_failures do
      piece = FactoryBot.create(:piece)
      piece.update(x: 1)
      piece.update(y: 1)
      piece.update(destination_x: 1)
      piece.update(destination_y: 8)
      coordinates = piece.horizontal_or_verticle_path
      expect(coordinates.length).to eq 6
      expect(coordinates.include?([1, 2])).to eq true
      expect(coordinates.include?([1, 3])).to eq true
      expect(coordinates.include?([1, 4])).to eq true
      expect(coordinates.include?([1, 5])).to eq true
      expect(coordinates.include?([1, 6])).to eq true
      expect(coordinates.include?([1, 7])).to eq true
    end

    it "should collect a list of coordinates when going downwards", :aggregate_failures do
      piece = FactoryBot.create(:piece)
      piece.update(x: 1)
      piece.update(y: 8)
      piece.update(destination_x: 1)
      piece.update(destination_y: 1)
      coordinates = piece.horizontal_or_verticle_path
      expect(coordinates.length).to eq 6
      expect(coordinates.include?([1, 7])).to eq true
      expect(coordinates.include?([1, 6])).to eq true
      expect(coordinates.include?([1, 5])).to eq true
      expect(coordinates.include?([1, 4])).to eq true
      expect(coordinates.include?([1, 3])).to eq true
      expect(coordinates.include?([1, 2])).to eq true
    end
  end

  describe "diagonal_path function" do
    it "should collect a list of coordinates when going north west", :aggregate_failures do
      piece = FactoryBot.create(:piece)
      piece.update(x: 8)
      piece.update(y: 1)
      piece.update(destination_x: 1)
      piece.update(destination_y: 8)
      coordinates = piece.diagonal_path
      expect(coordinates.length).to eq 6
      expect(coordinates.include?([7, 2])).to eq true
      expect(coordinates.include?([6, 3])).to eq true
      expect(coordinates.include?([5, 4])).to eq true
      expect(coordinates.include?([4, 5])).to eq true
      expect(coordinates.include?([3, 6])).to eq true
      expect(coordinates.include?([2, 7])).to eq true
    end

    it "should collect a list of coordinates when going south east", :aggregate_failures do
      piece = FactoryBot.create(:piece)
      piece.update(x: 1)
      piece.update(y: 8)
      piece.update(destination_x: 8)
      piece.update(destination_y: 1)
      coordinates = piece.diagonal_path
      expect(coordinates.length).to eq 6
      expect(coordinates.include?([2, 7])).to eq true
      expect(coordinates.include?([3, 6])).to eq true
      expect(coordinates.include?([4, 5])).to eq true
      expect(coordinates.include?([5, 4])).to eq true
      expect(coordinates.include?([6, 3])).to eq true
      expect(coordinates.include?([7, 2])).to eq true
    end

    it "should collect a list of coordinates when going north east", :aggregate_failures do
      piece = FactoryBot.create(:piece)
      piece.update(x: 1)
      piece.update(y: 1)
      piece.update(destination_x: 8)
      piece.update(destination_y: 8)
      coordinates = piece.diagonal_path
      expect(coordinates.length).to eq 6
      expect(coordinates.include?([2, 2])).to eq true
      expect(coordinates.include?([3, 3])).to eq true
      expect(coordinates.include?([4, 4])).to eq true
      expect(coordinates.include?([5, 5])).to eq true
      expect(coordinates.include?([6, 6])).to eq true
      expect(coordinates.include?([7, 7])).to eq true
    end

    it "should collect a list of coordinates when going south west", :aggregate_failures do
      piece = FactoryBot.create(:piece)
      piece.update(x: 8)
      piece.update(y: 8)
      piece.update(destination_x: 1)
      piece.update(destination_y: 1)
      coordinates = piece.diagonal_path
      expect(coordinates.length).to eq 6
      expect(coordinates.include?([2, 2])).to eq true
      expect(coordinates.include?([3, 3])).to eq true
      expect(coordinates.include?([4, 4])).to eq true
      expect(coordinates.include?([5, 5])).to eq true
      expect(coordinates.include?([6, 6])).to eq true
      expect(coordinates.include?([7, 7])).to eq true
    end
  end

  describe "path_clear? function" do
    it "should return false if any piece coordinates match any of the given path coordinates" do
      game = FactoryBot.create(:game)
      piece = FactoryBot.create(:piece, game_id: game.id)
      expect(piece.path_clear?([[5, 4], [5, 5], [5, 6]])).to eq false
    end

    it "should return true if no piece coordinates match any of the given path coordinates" do
      game = FactoryBot.create(:game)
      piece = FactoryBot.create(:piece, game_id: game.id)
      expect(piece.path_clear?([[1, 4], [1, 5], [1, 6]])).to eq true
    end
  end

  describe "horizontal_move? function" do
    it "should return true if the starting and ending coordinates are horizontal", :aggregate_failures do
      piece = FactoryBot.create(:piece)
      piece.update(destination_x: 8)
      piece.update(destination_y: 5)
      expect(piece.horizontal_move?).to eq true
      piece.update(destination_x: 2)
      piece.update(destination_y: 5)
      expect(piece.horizontal_move?).to eq true
    end

    it "should return false if the starting and ending coordinates are not horizontal", :aggregate_failures do
      piece = FactoryBot.create(:piece)
      piece.update(destination_x: 8)
      piece.update(destination_y: 7)
      expect(piece.horizontal_move?).to eq false
      piece.update(destination_x: 2)
      piece.update(destination_y: 3)
      expect(piece.horizontal_move?).to eq false
    end
  end

  describe "verticle_move? function" do
    it "should return true if the starting and ending coordinates are verticle", :aggregate_failures do
      piece = FactoryBot.create(:piece)
      piece.update(destination_x: 5)
      piece.update(destination_y: 8)
      expect(piece.verticle_move?).to eq true
      piece.update(destination_x: 5)
      piece.update(destination_y: 2)
      expect(piece.verticle_move?).to eq true
    end

    it "should return false if the starting and ending coordinates are not verticle", :aggregate_failures do
      piece = FactoryBot.create(:piece)
      piece.update(destination_x: 7)
      piece.update(destination_y: 8)
      expect(piece.verticle_move?).to eq false
      piece.update(destination_x: 3)
      piece.update(destination_y: 2)
      expect(piece.verticle_move?).to eq false
    end
  end

  describe "diagonal_move? function" do
    it "should return true if the starting and ending coordinates are diagonal", :aggregate_failures do
      piece = FactoryBot.create(:piece)
      piece.update(destination_x: 7)
      piece.update(destination_y: 7)
      expect(piece.diagonal_move?).to eq true
      piece.update(destination_x: 3)
      piece.update(destination_y: 3)
      expect(piece.diagonal_move?).to eq true
      piece.update(destination_x: 3)
      piece.update(destination_y: 7)
      expect(piece.diagonal_move?).to eq true
      piece.update(destination_x: 8)
      piece.update(destination_y: 2)
      expect(piece.diagonal_move?).to eq true
    end

    it "should return false if the starting and ending coordinates are not diagonal", :aggregate_failures do
      piece = FactoryBot.create(:piece)
      piece.update(destination_x: 2)
      piece.update(destination_y: 1)
      expect(piece.diagonal_move?).to eq false
      piece.update(destination_x: 6)
      piece.update(destination_y: 1)
      expect(piece.diagonal_move?).to eq false
      piece.update(destination_x: 3)
      piece.update(destination_y: 6)
      expect(piece.diagonal_move?).to eq false
      piece.update(destination_x: 8)
      piece.update(destination_y: 6)
      expect(piece.diagonal_move?).to eq false
    end
  end

  describe "friendly_capture? function" do
    it "should return true if a piece's destination is occupied by a friendly piece" do
      game = FactoryBot.create(:game)
      game.pieces.create(x: 4, y: 4, color: "black")
      piece = FactoryBot.create(:piece, game_id: game.id)
      expect(piece.friendly_capture?).to eq true
    end

    it "should return false if a piece's destination is occupied by an opposing piece" do
      game = FactoryBot.create(:game)
      game.pieces.create(x: 4, y: 4, color: "white")
      piece = FactoryBot.create(:piece, game_id: game.id)
      expect(piece.friendly_capture?).to eq false
    end

    it "should return false if a piece's destination isn't occupied at all" do
      game = FactoryBot.create(:game)
      piece = FactoryBot.create(:piece, game_id: game.id)
      expect(piece.friendly_capture?).to eq false
    end
  end

  describe "double_jump? function" do
    it "should return true if the piece wants to advance by two tiles from the starting point" do
      piece = FactoryBot.create(:piece)
      piece.update(x: 1)
      piece.update(y: 7)
      piece.update(destination_x: 1)
      piece.update(destination_y: 5)
      expect(piece.double_jump?(:-, 7)).to eq true
    end

    it "should return false if there is a piece directly in the way" do
      game = FactoryBot.create(:game)
      game.pieces.create(x: 1, y: 6)
      piece = FactoryBot.create(:piece, game_id: game.id)
      piece.update(x: 1)
      piece.update(y: 7)
      piece.update(destination_x: 1)
      piece.update(destination_y: 5)
      expect(piece.double_jump?(:-, 7)).to eq false
    end

    it "should return false if there is a piece at the destination" do
      game = FactoryBot.create(:game)
      game.pieces.create(x: 1, y: 5)
      piece = FactoryBot.create(:piece, game_id: game.id)
      piece.update(x: 1)
      piece.update(y: 7)
      piece.update(destination_x: 1)
      piece.update(destination_y: 5)
      expect(piece.double_jump?(:-, 7)).to eq false
    end

    it "should not return true if the piece isn't trying to move forward by two tiles", :aggregate_failures do
      piece = FactoryBot.create(:piece)
      piece.update(x: 1)
      piece.update(y: 2)
      piece.update(destination_x: 1)
      piece.update(destination_y: 5)
      expect(piece.double_jump?(:+, 2)).not_to eq true
      piece.update(destination_x: 1)
      piece.update(destination_y: 1)
      expect(piece.double_jump?(:+, 2)).not_to eq true
      piece.update(destination_x: 8)
      piece.update(destination_y: 8)
      expect(piece.double_jump?(:+, 2)).not_to eq true
      piece.update(destination_x: 1)
      piece.update(destination_y: 8)
      expect(piece.double_jump?(:+, 2)).not_to eq true
      piece.update(destination_x: 4)
      piece.update(destination_y: 4)
      expect(piece.double_jump?(:+, 2)).not_to eq true
    end
  end

  describe "promoted? function" do
    it "should return true if a given piece type isn't equal to a piece's type" do
      piece = FactoryBot.create(:piece)
      expect(piece.promoted?("pawn")).to eq true
    end

    it "should return false if a given piece type is equal to a piece's type" do
      piece = FactoryBot.create(:piece, piece_type: "pawn")
      expect(piece.promoted?("pawn")).to eq false
    end
  end

  describe "on_row? function" do
    it "should return true if a piece is on a given row" do
      piece = FactoryBot.create(:piece)
      expect(piece.on_row?(5)).to eq true
    end

    it "should return false if a piece isn't on a given row" do
      piece = FactoryBot.create(:piece)
      expect(piece.on_row?(6)).to eq false
    end
  end

  describe "current_turn? function" do
    before do
      @user = FactoryBot.create(:user)
    end

    it "should return true if the current user is playing as white when it's white's turn" do
      game = FactoryBot.create(:game, whites_turn: true, as_white: @user.username)
      piece = FactoryBot.create(:piece, game_id: game.id)
      expect(piece.current_turn?(@user)).to eq true
    end

    it "should return false if the current user is not playing as white when it's white's turn" do
      game = FactoryBot.create(:game, whites_turn: true, as_white: "someone else")
      piece = FactoryBot.create(:piece, game_id: game.id)
      expect(piece.current_turn?(@user)).to eq false
    end

    it "should return true if the current user is playing as black when it's blacks's turn" do
      game = FactoryBot.create(:game, whites_turn: false, as_black: @user.username)
      piece = FactoryBot.create(:piece, game_id: game.id)
      expect(piece.current_turn?(@user)).to eq true
    end

    it "should return false if the current user is not playing as black when it's black's turn" do
      game = FactoryBot.create(:game, whites_turn: false, as_black: "someone else")
      piece = FactoryBot.create(:piece, game_id: game.id)
      expect(piece.current_turn?(@user)).to eq false
    end
  end

  describe "correct_color? function" do
    before do
      @user = FactoryBot.create(:user)
    end

    it "should return true if the current user is playing as white when dealing with a white piece" do
      game = FactoryBot.create(:game, as_white: @user.username)
      piece = FactoryBot.create(:piece, game_id: game.id, color: "white")
      expect(piece.correct_color?(@user)).to eq true
    end

    it "should return false if the current user is playing as black when dealing with a white piece" do
      game = FactoryBot.create(:game, as_black: @user.username)
      piece = FactoryBot.create(:piece, game_id: game.id, color: "white")
      expect(piece.correct_color?(@user)).to eq false
    end

    it "should return true if the current user is playing as black when dealing with a black piece" do
      game = FactoryBot.create(:game, as_black: @user.username)
      piece = FactoryBot.create(:piece, game_id: game.id, color: "black")
      expect(piece.correct_color?(@user)).to eq true
    end

    it "should return false if the current user is playing as white when dealing with a black piece" do
      game = FactoryBot.create(:game, as_white: @user.username)
      piece = FactoryBot.create(:piece, game_id: game.id, color: "black")
      expect(piece.correct_color?(@user)).to eq false
    end
  end
end
