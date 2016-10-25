class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def edit
  end

  def show
    @user = this_user
  end

  # def destroy
  #   current_album.destroy
  #   redirect_to admin_albums_path
  # end
  #
  # private
  #
  # def current_album
  #   Album.find(params[:id])
  # end

  private

    def this_user
      User.find(params[:id])
    end
end
