class AlbumsController < ApplicationController
  def index
    if current_user
      @albums = current_user.albums
    else
      @albums = Album.where(public: true)
    end
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    @album.user_id = current_user.id
    if @album.save
      redirect_to album_path(@album)
    else

    end
  end

  def show
    @album = Album.find(params[:id])
  end

  private

    def album_params
      params.require(:album).permit(:title, :description, :public)
    end
end
