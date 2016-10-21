Fabricator(:photo) do
  caption { Faker::Name.title }
  image
end
