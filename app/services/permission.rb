class Permission
  def initialize(user:, controller:, action:)
    @user = user || User.new
    @controller = controller
    @action = action
  end

  def authorized?
    if user.admin?
      return true if controller == "home" && action.in?(%w(index))
      return true if controller == "albums" && action.in?(%w(index))
      false
    elsif user.registered?
      return true if controller == "home" && action.in?(%w(index))
      return true if controller == "albums" && action.in?(%w(index))
      false
    else
      return true if controller == "home" && action.in?(%w(index))
      return true if controller == "albums" && action.in?(%w(index))
      false
    end
  end

  private
    attr_reader :user,
                :controller,
                :action
end
