class GamesController < ApplicationController
  before_action :authenticate_user!

  def new
    @game = Game.new
  end

  def create
    @game = current_user.games.create(game_params)
    @game.assign_host(current_user)
    @game.make_pieces
    @game.create_lobby_token(current_user)
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
    @game.assign_guest(current_user)
    @game.manage_token
    @comments = @game.comments.all
    SendLobbyTokensJob.perform_later
    SendGameAndPiecesJob.perform_later(@game)
  end

  def destroy
    game = Game.find_by_id(params[:id])
    game.pieces.destroy_all if game
    game.destroy if game
    game.lobby_tokens.destroy_all if game
    game.comments.destroy_all if game
    SendLobbyTokensJob.perform_later
    redirect_to root_path
  end

  private

  def game_params
    params.require(:game).permit(:host_as_white)
  end

end
