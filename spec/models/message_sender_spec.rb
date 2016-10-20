require 'rails_helper'

RSpec.describe MessageSender, type: :model do
  it "sends an SMS message" do
    VCR.use_cassette("Send sms") do
      MessageSender.send_code(ENV['MY_PHONE_NUMBER'], 'George Cloney!')
    end
  end
end
