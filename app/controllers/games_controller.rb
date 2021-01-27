class GamesController < ApplicationController
  before_action :authenticate_user!

  def new
    @game = Game.new
  end

  def create
    @game = current_user.games.create(game_params)
    @game.assign_host(current_user)
    @game.make_pieces
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
    @game.assign_guest(current_user)
    @game.handle_open_status
    SendGameAndPiecesJob.perform_later(@game)
  end

  def destroy
    game = Game.find(params[:id])
    game.pieces.destroy_all
    game.destroy
    redirect_to root_path
  end

  private

  def game_params
    params.require(:game).permit(:host_as_white)
  end

end
