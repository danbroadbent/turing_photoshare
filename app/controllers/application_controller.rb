class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authorize!

  helper_method :current_user

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # def guest_user?
  #   session[:user_id].nil?
  # end

  def current_permission
    Permission.new(user: current_user,
                   controller: params[:controller],
                   action: params[:action])
  end

  def authorize!
    unless current_permission.authorized?
# For debugging only. Remove before going to production.
puts "#{params[:controller]} - #{params[:action]}"

      redirect_to albums_path, danger: "The page you requested is not available or does not exist."
    end
  end
end
