module TokenSender
  def self.send_token_to(user)
    api_token = TokenGenerator.generate
    user.update(api_token: api_token)
    UserMailer.api_token_email(user).deliver_now
  end
end
