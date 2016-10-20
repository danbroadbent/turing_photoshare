require 'rails_helper'

RSpec.describe MessageSender, type: :model do
  it "sends an SMS message" do
    MessageSender.send_code(ENV['MY_PHONE_NUMBER'], 'George Cloney!')
  end
end
