class UserProfilesController < ApplicationController
  def edit
    @user_profile = current_profile
  end

  def update
    @user_profile = current_profile
    @user_profile.update(user_profile_params)
    redirect_to user_path
  end

  def current_profile
    UserProfile.find(params[:id])
  end

  private

  def user_profile_params
    params.require(:user_profile).permit(:username, :email, :phone_number, :bio)
  end
end
