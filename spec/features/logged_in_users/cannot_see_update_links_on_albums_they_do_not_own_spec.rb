require 'rails_helper'

RSpec.feature "user cannot see edits photo" do
  scenario "from album page that he does not own" do
    user = Fabricate(:user)
    user2 = Fabricate(:user)
    album = Fabricate(:album)
    album_2 = Fabricate(:album)
    photo = Fabricate(:photo, caption: "Here I am", user: user, album: album)
    Fabricate(:album_user, user: user, album: album, owner: false)
    Fabricate(:album_user, user: user, album: album_2, owner: true)
    Fabricate(:album_user, user: user2, album: album, owner: true)
    stub_login_user(user)

    visit album_path(album)
    expect(current_path).to eq(album_path(album))
    expect(page).to have_content("Here I am")

    expect(page).to_not have_content("Edit caption")
  end
end
