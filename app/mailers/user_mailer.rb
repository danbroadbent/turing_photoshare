class UserMailer < ApplicationMailer
  def api_token_email(user)
    @user = user
    mail(to: @user.email, subject: "API Token")
  end
end
