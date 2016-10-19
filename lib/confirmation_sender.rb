module ConfirmationSender
  def self.send_confirmation_to(user)
    verification_code = CoderGenerator.generate
    user.update(verification_code: verification_code)
    MessageSender.send_code(user.user_profile.phone_number, verification_code)
  end
end
