class AlbumUsersController < ApplicationController
  def new
    @album_id = params[:album_id]
    @album_user = AlbumUser.new
  end

  def create
    user_id = User.find_by_username(params[:username]).id
    AlbumUser.new(user_id: user_id,
                  album_id: params[:album_user][:album_id],
                  owner: false)
    redirect_to album_path(Album.find(params[:album_user][:album_id]))
  end

  private
    # def album_users_params
    #   params.require(:album_users).permit(:title, :description, :public)
    # end
end
