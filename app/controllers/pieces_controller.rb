class PiecesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def update
    piece = Piece.find(params[:id])
    piece.update(piece_params)
    piece.update_x_and_y(
      piece.destination_x,
      piece.destination_y
    )
    piece.capture_piece
    SendGameAndPiecesJob.perform_later(piece.game)
  end

  private

  def piece_params
    params.require(:piece).permit(:destination_x, :destination_y)
  end

end
