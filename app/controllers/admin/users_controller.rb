class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def edit
    @user = this_user
    @user_profile = @user.user_profile
  end

  def show
    @user = this_user
  end

  def update
    this_user.update(role: set_role)
    this_user.update(active: set_active)
    this_user.update(password: params[:pasword])
    this_user.user_profile.update(username: params[:username])
    this_user.user_profile.update(email: params[:email])
    this_user.user_profile.update(phone_number: params[:phone_number])
    this_user.user_profile.update(bio: params[:bio])
    redirect_to admin_user_path(this_user)
  end

  def destroy
    this_user.destroy
    redirect_to admin_users_path
  end

  private

    def this_user
      User.find(params[:id])
    end

    def set_role
      params[:user][:role] ? 1 : 0
    end

    def set_active
      params[:user][:active] == true
    end
end
