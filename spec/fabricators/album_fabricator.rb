Fabricator(:album) do
  title { Faker::Name.title }
  description "MyText"
  public      false
end
