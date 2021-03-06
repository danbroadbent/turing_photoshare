class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user_profile = UserProfile.new(
      user: @user,
      username: params[:user][:user_profile][:username],
      phone_number: params[:user][:user_profile][:phone_number])
    if @user.save && @user_profile.save
      set_session
      ConfirmationSender.send_confirmation_to(@user)
      redirect_to new_confirmation_path
    else
      flash[:info] = "Oops. Something didn't look right. Please try again."
      render :new
    end
  end

  def show
    @user = current_user
  end

  def update
    if current_user.email
      TokenSender.send_token_to(current_user)
      flash[:success] = "Your API Token has been emailed to #{current_user.email}."
      redirect_to user_path
    else
      flash[:danger] = "Token Generation Failed! Please add a valid email address."
      redirect_to user_path
    end
  end

  private

    def user_params
      params.require(:user).permit(:role,
                                   :password,
                                   :password_confirmation,
                                   :active,
                                   :verification_code,
                                   :api_token)
    end

    def set_session
      session[:user_id] = @user.id
      session[:guesses] = 0
    end
end
