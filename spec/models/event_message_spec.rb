require 'rails_helper'

RSpec.describe EventMessage, type: :model do
  describe "create_capture_message function" do
    it "should create a message that describes the piece that was captured" do
      game = FactoryBot.create(:game)
      piece = FactoryBot.create(:piece)
      event_message = EventMessage.create_capture_message(game, piece)
      expect(event_message.content).to eq "The black queen at e5 was captured."
    end
  end

  describe "create_movement_message function" do
    it "should create a message that describes the piece that moved" do
      game = FactoryBot.create(:game)
      piece = FactoryBot.create(:piece)
      event_message = EventMessage.create_movement_message(game, piece)
      expect(event_message.content).to eq "The black queen moved to e5."
    end
  end

  describe "create_illegal_jump_over_message function" do
    it "should create a message that describes an illegal jomp over attempt" do
      game = FactoryBot.create(:game)
      piece = FactoryBot.create(:piece)
      selected_piece = FactoryBot.create(:piece, color: "white", x: 3)
      event_message = EventMessage.create_illegal_jump_over_message(game, selected_piece, piece)
      expect(event_message.content).to eq "The white queen at c5 isn't allowed to jump over the black queen at e5."
    end
  end

  describe "translate_coordinates_to_board_format function" do
    it "should translate a piece's coordinates to board format", :aggregate_failures do
      piece = FactoryBot.create(:piece, x: 1, y: 1)
      expect(EventMessage.translate_coordinates_to_board_format(piece)).to eq "a1"

      piece.update(x: 2, y: 2)
      expect(EventMessage.translate_coordinates_to_board_format(piece)).to eq "b2"

      piece.update(x: 3, y: 3)
      expect(EventMessage.translate_coordinates_to_board_format(piece)).to eq "c3"

      piece.update(x: 4, y: 4)
      expect(EventMessage.translate_coordinates_to_board_format(piece)).to eq "d4"

      piece.update(x: 5, y: 5)
      expect(EventMessage.translate_coordinates_to_board_format(piece)).to eq "e5"

      piece.update(x: 6, y: 6)
      expect(EventMessage.translate_coordinates_to_board_format(piece)).to eq "f6"

      piece.update(x: 7, y: 7)
      expect(EventMessage.translate_coordinates_to_board_format(piece)).to eq "g7"

      piece.update(x: 8, y: 8)
      expect(EventMessage.translate_coordinates_to_board_format(piece)).to eq "h8"
    end
  end
end
