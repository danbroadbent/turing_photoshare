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
    @album.user_id = current_user.id
    if @album.save
      redirect_to album_path(@album)
    else

    end
  end

  def show
    # redirect_to login_path if guest_accessing_private_album?
    @album = current_album
  end

  def destroy
    album_title = current_album.title
    delete_photos
    current_album.delete
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

    def delete_photos
      current_album.photos.each { |photo| photo.delete }
    end

    # def guest_accessing_private_album?
    #   guest_user? && current_album.private?
    # end
end
