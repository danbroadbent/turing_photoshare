class MyAlbumsController < ApplicationController
  def index
    @albums = Album.where(user_id: current_user.id)
  end
end
