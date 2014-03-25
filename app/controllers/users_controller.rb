class UsersController < ApplicationController

  before_filter :authenticate_user!

  def index
  end

  def show
    gon.users_show = 'anything'
    self.gon_audio_for_piece(LibraryPieceSplashScreen.archive)
    render :splash
  end
end
