require 'rails_helper'

RSpec.feature "Logged in visits my albums path" do
  scenario "they see all albums they've uploaded or been invited to" do
    user = Fabricate(:user)
    albums = Fabricate.times(2, :album)
    Fabricate(:album_user, user: user, album: albums.first, owner: true)
    Fabricate(:album_user, user: user, album: albums.last, owner: false)
    stub_login_user(user)

    visit my_albums_path

    expect(page).to have_content(albums.first.title)
    expect(page).to have_content(albums.last.title)
  end

  scenario "they don't see albums they haven't been invited to" do
    user = Fabricate(:user)
    album = Fabricate(:album)
    stub_login_user(user)

    visit my_albums_path

    expect(page).to_not have_content(album.title)
  end
end
