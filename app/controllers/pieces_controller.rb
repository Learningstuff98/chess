class PiecesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def update
    piece = Piece.find(params[:id])
    piece.update(piece_params)
    piece.valid_move?
    piece.capture_piece
    SendGameAndPiecesJob.perform_later(piece.game)
  end

  private

  def piece_params
    params.require(:piece).permit(:destination_x, :destination_y, :piece_type, :icon)
  end

end
