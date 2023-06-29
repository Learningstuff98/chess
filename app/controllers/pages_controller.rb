class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:lobby]

  def home; end

  def lobby
    @games = Game.vacant_games
  end
end
