require 'rails_helper'

RSpec.describe ConfirmationSender do
  it "updates a users verification_code" do
    user = Fabricate(:user, verification_code: "abc")
    Fabricate(:user_profile, user: user)
    ConfirmationSender.send_confirmation_to(user)
    expect(user.verification_code).to_not eq("abc")
  end
end
