Fabricator(:user) do
  username { Faker::Internet.user_name }
  role 0
  password_digest 'password'
  active true
  verification_code '123456'
  phone_number ENV['MY_PHONE_NUMBER']
end
