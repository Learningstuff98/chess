class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:lobby]

  def home
  end

  def lobby
    @lobbytokens = LobbyToken.all
  end

end
