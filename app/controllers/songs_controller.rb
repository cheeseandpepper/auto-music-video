class SongsController < ApplicationController

  def index
    @song = Song.new
  end

  def new
    @song = Song.new
  end

  def create
  
    @song = Song.create(song_params)

  end


  private
  def song_params
    params.require(:song).permit(:title, :artist, :genre, :beat_onsets)
  end

end
