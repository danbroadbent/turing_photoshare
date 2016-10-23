module TokenSender
  def self.send_token_to(user)
    api_token = TokenGenerator.generate
    user.update(api_token: api_token)
    # user.save
  end
end
