class Permission
  def initialize(user:, controller:, action:)
    @user = user || User.new
    @controller = controller
    @action = action
  end

  def authorized?
# For debugging only. Remove before going to production.
puts "#{controller} - #{action}"

    if user.admin?
      return true if controller == "home" && action.in?(%w(index))
      return true if controller == "albums" && action.in?(%w(index show new create))
      return true if controller == "users" && action.in?(%w(show))
      return true if controller == "confirmations" && action.in?(%w(new create))
      return true if controller == "comments" && action.in?(%w(create))
      return true if controller == "photos" && action.in?(%w(new create))
      return true if controller == "sessions" && action.in?(%w(destroy))
      return true if controller == "user_profiles" && action.in?(%w(edit update))
      false
    elsif user.registered?
      return true if controller == "home" && action.in?(%w(index))
      return true if controller == "albums" && action.in?(%w(index show new create))
      return true if controller == "users" && action.in?(%w(show))
      return true if controller == "confirmations" && action.in?(%w(new create))
      return true if controller == "comments" && action.in?(%w(create))
      return true if controller == "photos" && action.in?(%w(new create))
      return true if controller == "sessions" && action.in?(%w(destroy))
      return true if controller == "user_profiles" && action.in?(%w(edit update))
      false
    else
      return true if controller == "home" && action.in?(%w(index))
      return true if controller == "albums" && action.in?(%w(index))
      return true if controller == "users" && action.in?(%w(new create))
      return true if controller == "sessions" && action.in?(%w(new create))
      # return true if controller == "confirmations" && action.in?(%w(new))
      false
    end
  end

  private
    attr_reader :user,
                :controller,
                :action
end
