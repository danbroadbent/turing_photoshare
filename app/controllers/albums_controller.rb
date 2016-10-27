class AlbumsController < ApplicationController
  def index
    @albums = Album.find_all_public
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    @album.users << current_user
    @album.album_users.update(owner: true)
    @album.save
    redirect_to album_path(@album)
  end

  def show
    if current_user.active_albums.include?(current_album) || admin_user?
    # if current_album.permitted?(current_user) || admin_user?
      @album = current_album
    else
      flash[:info] = "The requested page does not exist or is no longer available."
      redirect_to root_path
    end
  end

  def destroy
    album_title = current_album.title
    current_album.destroy
    flash[:success] = "Album '#{album_title}' has been deleted."
    redirect_to my_albums_path
  end

  def edit
    @album = current_album
  end

  def update
    current_album.update(album_params)
    redirect_to album_path(current_album)
  end

  private
    def album_params
      params.require(:album).permit(:title, :description, :public)
    end

    def current_album
      Album.find(params[:id])
    end
end
