# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def api_token_email
    UserMailer.api_token_email(User.first)
  end
end
