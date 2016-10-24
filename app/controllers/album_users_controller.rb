class AlbumUsersController < ApplicationController
  def new
    @album_id = params[:album_id]
    @album_user = AlbumUser.new
  end

  def create
    user_id = User.find_by_username(params[:username]).id
    album_user = AlbumUser.new(user_id: user_id,
                  album_id: params[:album_user][:album_id],
                  owner: false)
    if album_user.save
      flash[:success] = "Successfully shared album '#{album.title}' with '#{params[:username]}'"
      redirect_to album_path(album)
    else

    end
  end

  private
    def album
      Album.find(params[:album_user][:album_id])
    end
    # def album_users_params
    #   params.require(:album_users).permit(:title, :description, :public)
    # end
end
