class MyAlbumsController < ApplicationController
  def index
    @albums = current_user.active_albums
  end
end
