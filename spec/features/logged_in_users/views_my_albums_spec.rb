require 'rails_helper'

RSpec.feature "Logged in visits my albums path" do
  scenario "they see all albums they've uploaded" do
    user = Fabricate(:user)
    albums = Fabricate.times(2, :album)
    Fabricate(:album_user, user: user, album: albums.first)
    Fabricate(:album_user, user: user, album: albums.last)
    stub_login_user(user)

    visit my_albums_path

    expect(page).to have_content(albums.first.title)
    expect(page).to have_content(albums.last.title)
  end

  xscenario "they see all albums they've been invited to" do

  end
end
