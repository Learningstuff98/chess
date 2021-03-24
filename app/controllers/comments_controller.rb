class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def create
    game = Game.find(params[:game_id])
    comment = game.comments.create(comment_params)
    comment.update_attribute(:username, current_user.username)
    SendCommentJob.perform_later(game)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
