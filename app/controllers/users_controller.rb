class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user_profile = UserProfile.new(user: @user, username: params[:user][:user_profile][:username], phone_number: params[:user][:user_profile][:phone_number])
    if @user.save && @user_profile.save
      session[:user_id] = @user.id
      ConfirmationSender.send_confirmation_to(@user)
      redirect_to new_confirmation_path
    else
      render :new
    end
  end

  def show
    @user = current_user
  end

  def update
    @user = current_user
    TokenSender.send_token_to(@user)
    redirect_to '/profile'
  end

  private

  def user_params
    params.require(:user).permit(:role,
                                 :password,
                                 :active,
                                 :verification_code,
                                 :api_token)
  end
end
