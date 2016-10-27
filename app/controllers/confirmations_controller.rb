class ConfirmationsController < ApplicationController
  def new
    @user = current_user
  end

  def create
    @user = User.find(session[:user_id])
    @user.incrament_guesses

    if @user.verification_code == params[:verification_code]
      session[:authenticated] = true

      flash[:success] = "You are logged in as #{@user.username}. I hope you like pictures!"
      redirect_to user_path(@user)
    else
      @user.reset_confirmation if @user.too_many_guesses
      flash.now[:warning] = "Verification code is incorrect."
      render :new
    end
  end
end
