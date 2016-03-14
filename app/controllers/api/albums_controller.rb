class Api::AlbumsController < Api::BaseController
  def index
    @albums = Album.where(archived: false)
    if artist = params[:artist_id]
        @albums = @albums.where(artist_id: artist)
    end
    render status: 200 
  end
    
  def show
    @album = Album.find_unarchived(params[:id])
    if @album
      render status: 200
    else
      head 404
    end
  end
    
  def create
    @album = Album.new(allowed_attributes)
    if @album.save
      render :show, status: 201
    else
      render json: @album.errors, status: 400 
    end
  end
    
  def update
    @album = Album.find(params[:id])
    if @album.update(allowed_attributes)
      render :show, status: 200
    else
      render json: @album.errors, status: 400
    end
  end
    
  def destroy
    album = Album.find_unarchived(params[:id])
    album.archive
    head 204
  end
    
  private
    
  def allowed_attributes
    params.fetch(:album, {}).permit(:name, :price, :artist_id)
  end
end