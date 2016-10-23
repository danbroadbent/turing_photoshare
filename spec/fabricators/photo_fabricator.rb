Fabricator(:photo) do
  caption { Faker::Name.title }
  image {Faker::Avatar.image}
end
