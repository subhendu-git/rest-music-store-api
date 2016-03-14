class Api::ArtistsController < Api::BaseController
  def index
    @artists = Artist.where(archived: false)
    render status: 200 
  end
    
  def show
    @artist = Artist.find_unarchived(params[:id])
    if @artist
      render status: 200
    else
      head 404
    end
  end
    
  def create
    @artist = Artist.new(allowed_attributes)
    if @artist.save
      render :show, status: 201
    else
      render json: @artist.errors, status: 400
    end
  end
    
  def update
    @artist = Artist.find(params[:id])
    if @artist.update(allowed_attributes)
      render :show, status: 200
    else
      render json: @artist.errors, status: 400 
    end
  end
    
  def destroy
    artist = Artist.find_unarchived(params[:id])
    artist.archive
    head 204
  end
    
  private
    
  def allowed_attributes
    params.fetch(:artist, {}).permit(:name, :birthdate)
  end
end