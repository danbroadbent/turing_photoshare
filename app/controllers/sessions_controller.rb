class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      ConfirmationSender.send_confirmation_to(user)
      redirect_to new_confirmation_path
    else
      flash.now['alert_danger'] = 'Invalid Username or Password'
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to albums_path
  end
end
