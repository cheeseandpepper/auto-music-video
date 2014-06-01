class SongsController < ApplicationController

  def index
    @songs = AWS::S3::Bucket.find('automusicvideosongs').objects # NameError (uninitialized constant SongsController::BUCKET)
    #@song_url = AWS::S3::S3Object.url_for(song_key, 'automusicvideosongs', :authenticated => false)
    #@meta_data = view_context.analysis_json
  end

  def upload
    begin
        AWS::S3::S3Object.store(sanitize_filename(params[:mp3file].original_filename), params[:mp3file].read, 'automusicvideosongs', :access => :public_read)
        redirect_to root_path
    rescue
        render :text => "Couldn't complete the upload"
    end
  end

  def delete
    if (params[:song])
      AWS::S3::S3Object.find(params[:song], 'automusicvideosongs').delete
      redirect_to root_path
    else
      render :text => "No song was found to delete!"
    end
  end

  private
 
  def sanitize_filename(file_name)
    just_filename = File.basename(file_name)
    just_filename.sub(/[^\w\.\-]/,'_')
  end
  
  def song_params
    params.require(:song).permit(:title, :artist, :genre, :beat_onsets)
  end

end
