class Permission
  def initialize(user:, controller:, action:)
    @user = user || User.new
    @controller = controller
    @action = action
  end

  def authorized?
    if user.admin?
      return true if controller == "home" && action.in?(%w(index))
      return true if controller == "albums" && action.in?(%w(index show new create destroy edit update))
      return true if controller == "users" && action.in?(%w(show))
      return true if controller == "confirmations" && action.in?(%w(new create))
      return true if controller == "comments" && action.in?(%w(create destroy edit update))
      return true if controller == "photos" && action.in?(%w(new create destroy edit update))
      return true if controller == "my_albums" && action.in?(%w(index))
      return true if controller == "sessions" && action.in?(%w(destroy))
      return true if controller == "user_profiles" && action.in?(%w(edit update))
      return true if controller == "album_users" && action.in?(%w(new create))
      return true if controller == "admin" && action.in?(%w(index))
      return true if controller == "admin/albums" && action.in?(%w(index destroy))
      return true if controller == "album/download" && action.in?(%w(index))
      return true if controller == "admin/users" && action.in?(%w(index edit show update destroy))
      false
    elsif user.registered?
      return true if controller == "home" && action.in?(%w(index))
      return true if controller == "albums" && action.in?(%w(index show new create destroy edit update))
      return true if controller == "users" && action.in?(%w(show update))
      return true if controller == "confirmations" && action.in?(%w(new create))
      return true if controller == "comments" && action.in?(%w(create destroy edit update))
      return true if controller == "photos" && action.in?(%w(new create destroy edit update))
      return true if controller == "my_albums" && action.in?(%w(index))
      return true if controller == "sessions" && action.in?(%w(destroy))
      return true if controller == "user_profiles" && action.in?(%w(edit update))
      return true if controller == "album_users" && action.in?(%w(new create))
      return true if controller == "album/download" && action.in?(%w(index))
      false
    else
      return true if controller == "albums" && action.in?(%w(index))
      return true if controller == "users" && action.in?(%w(new create))
      return true if controller == "sessions" && action.in?(%w(new create))
      return true if controller == "confirmations" && action.in?(%w(new create))
      return true if controller == "api/v1/comments" && action.in?(%w(create destroy edit update index show))
      false
    end
  end

  private
    attr_reader :user,
                :controller,
                :action
end
