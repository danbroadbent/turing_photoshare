class ConfirmationsController < ApplicationController
  def new
    @user = current_user
  end

  def create
    @user = User.find(session[:user_id])
    if @user.verification_code == params[:verification_code]
      session[:authenticated] = true
      flash[:notice] = "You are logged in as #{@user.username}. I hope you like pictures!!!"
      redirect_to user_path(@user)
    else
      flash.now[:error] = "Verification code is incorrect."
      render :new
    end
  end
end
