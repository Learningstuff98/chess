class GamesController < ApplicationController
  before_action :authenticate_user!

  def new
    @game = Game.new
  end

  def create
    @game = current_user.games.create(game_params)
    @game.assign_host(current_user)
    @game.make_pieces
    SendVacantGamesJob.perform_later
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
    @game.assign_guest(current_user)
    @comments = @game.comments.all
    SendVacantGamesJob.perform_later
    SendGameAndPiecesJob.perform_later(@game)
  end

  def destroy
    game = Game.find_by_id(params[:id])
    game&.destroy
    SendVacantGamesJob.perform_later
    redirect_to root_path
  end

  private

  def game_params
    params.require(:game).permit(:host_as_white)
  end
end
