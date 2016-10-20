module MessageSender
  def self.send_code(to_phone, message)
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token  = ENV['TWILIO_AUTH_TOKEN']
    from_phone  = ENV["TWILIO_NUMBER"]

    conn = Faraday.new(url: "https://api.twilio.com") do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
      faraday.basic_auth(account_sid, auth_token)
      faraday.headers['Content-Type'] = 'multipart/form-data; boundary=---api'
    end

    conn.post do |req|
      req.url "/2010-04-01/Accounts/#{account_sid}/Messages.json"
      req.body = "-----api\r\nContent-Disposition: form-data; name=\"From\"\r\n\r\n#{from_phone}\r\n-----api\r\nContent-Disposition: form-data; name=\"To\"\r\n\r\n#{to_phone}\r\n-----api\r\nContent-Disposition: form-data; name=\"Body\"\r\n\r\n#{message}\r\n-----api--"
    end
  end
end
