Fabricator(:user_profile) do
  username      { Faker::Internet.user_name }
  email         { Faker::Internet.email }
  phone_number  ENV['MY_PHONE_NUMBER']
  bio           { Faker::Lorem.sentence }
  user
end
