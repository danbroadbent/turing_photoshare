require 'rails_helper'

RSpec.describe "Seeding the database" do
  xit "verifies that the data is there" do
    require './db/seeds.rb'

    admins = User.where(role: 1)
    expect(User.count).to eq(1000)
    expect(admins.count).to eq(1)
    expect(admins.last.username).to eq("clancey007@example.com")
    expect(Album.count).to eq(5000)
    expect(User.first.albums.count).to eq(5)
    expect(User.last.albums.count).to eq(5)
  end
end
