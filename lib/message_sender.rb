module MessageSender
  def self.send_code(phone_number, code)
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token  = ENV['TWILIO_AUTH_TOKEN']
    conn = Faraday.new (url: "https://api.twilio.com/2010-04-01/Accounts/ACcb9b3309be2c1f0ad7c43550fd5fbf85/Messages.json") do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.header(account_sid, auth_token)
      faraday.params[:account_sid] = ENV['TWILIO_ACCOUNT_SID']
    end
    # client = Twilio::REST::Client.new(account_sid, auth_token)
    #
    message = client.messages.create(
      from:  ENV['TWILIO_NUMBER'],
      to:    phone_number,
      body:  code
    )
  end
end
