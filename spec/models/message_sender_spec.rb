require 'rails_helper'

RSpec.describe MessageSender, '#send_code' do
  it "sends an SMS message" do
    MessageSender.send_code(ENV['MY_PHONE_NUMBER'], 'message')
  end
end
