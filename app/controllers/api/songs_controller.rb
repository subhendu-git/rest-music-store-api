class Api::SongsController < Api::BaseController
  def index
    @songs = Song.where(archived: false)
    if artist = params[:artist_id]
        @songs = @songs.where(artist_id: artist)
    end
    if album = params[:album_id]
        @songs = @songs.where(album_id: album)
    end
    render status: 200 
  end
    
  def show
    @song = Song.find_unarchived(params[:id])
    if @song
      render status: 200
    else
      head 404
    end
  end
    
  def create
    @song = Song.new(allowed_attributes)
    if @song.save
      render :show, status: 201
    else
      render json: @song.errors, status: 400
    end
  end
    
  def update
    @song = Song.find(params[:id])
    if @song.update(allowed_attributes)
      render :show, status: 200
    else
      render json: @song.errors, status: 400 
    end
  end
    
  def destroy
    song = Song.find_unarchived(params[:id])
    song.archive
    head 204
  end
    
  private
    
  def allowed_attributes
    params.fetch(:song, {}).permit(:name, :genre, :time, :price, :artist_id, :album_id)
  end
end