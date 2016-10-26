require 'rails_helper'

RSpec.feature "user deletes photo" do
  scenario "from album page" do
    user = Fabricate(:user)
    album = Fabricate(:album)
    photo = Fabricate(:photo, caption: "Here I am", user: user, album: album)
    Fabricate(:album_user, user: user, album: album, owner: true)
    stub_login_user(user)

    visit album_path(album)

    expect(current_path).to eq(album_path(album))
    expect(page).to have_content("Here I am")

    within ".photo_tile" do
      click_on 'Delete photo'
    end

    expect(page).to_not have_content("Here I am")
  end
end
