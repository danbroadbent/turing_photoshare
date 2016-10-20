Fabricator(:album) do
  title { Faker::Name.title }
  description { Faker::Lorem.sentence }
  public false
end
