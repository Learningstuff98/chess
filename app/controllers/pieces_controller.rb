class PiecesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def update
    piece = Piece.find(params[:id])
    origional_piece_type = piece.piece_type
    piece.update(piece_params)
    piece.valid_move?(current_user)
    piece.game.invert_turn if PawnMovementProfile.promoted?(origional_piece_type, piece.piece_type)
    piece.capture_piece
    piece.game.victory?
    SendGameAndPiecesJob.perform_later(piece.game)
  end

  private

  def piece_params
    params.require(:piece).permit(:destination_x, :destination_y, :piece_type, :icon)
  end
end
