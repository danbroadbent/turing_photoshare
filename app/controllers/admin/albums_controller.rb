class Admin::AlbumsController < ApplicationController
  def index
    @albums = Album.all
  end
end
