class AlbumsController < ApplicationController
  def index
    if current_user
      @albums = current_user.albums
    else
      @albums = Album.find_all_public
    end
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    @album.users << current_user
    if @album.save
      redirect_to album_path(@album)
    else

    end
  end

  def show
    redirect_to root_path unless current_album.permitted?(current_user)
    @album = current_album
  end

  def destroy
    album_title = current_album.title
    delete_album
    flash[:success] = "Album '#{album_title}' has been deleted."
    redirect_to my_albums_path
  end

  private

    def album_params
      params.require(:album).permit(:title, :description, :public)
    end

    def current_album
      Album.find(params[:id])
    end

    def delete_album
      current_album.photos.delete_all
      current_album.album_users.delete_all
      current_album.comments.delete_all
      current_album.delete
    end
end
