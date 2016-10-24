class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authorize!

  helper_method :current_user, :guest_user?, :admin_user?

  def current_user
    @user ||= User.find(session[:user_id]) if session[:authenticated] == true
  end

  def guest_user?
    session[:authenticated] != true
  end

  def admin_user?
    current_user.admin?
  end

  def current_permission
    Permission.new(user: current_user,
                   controller: params[:controller],
                   action: params[:action])
  end

  def authorize!
    unless current_permission.authorized?
# For debugging only. Remove before going to production.
puts "\n\n****Did you update your permissions?****\n\n"
puts "Current user role: #{current_user.role}" if current_user
puts "Controller: #{params[:controller]} - Action: #{params[:action]}"

      redirect_to root_path, danger: "The page you requested is not available or does not exist."
    end
  end
end
