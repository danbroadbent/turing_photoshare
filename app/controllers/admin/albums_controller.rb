class Admin::AlbumsController < ApplicationController
  def index
    @albums = Album.all
  end

  def destroy
    current_album.destroy
    redirect_to admin_albums_path
  end

  private

  def current_album
    Album.find(params[:id])
  end
end
