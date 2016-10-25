require 'rails_helper'

RSpec.feature "user edits photo" do
  scenario "from album page" do
    user = Fabricate(:user)
    album = Fabricate(:album)
    photo = Fabricate(:photo, caption: "Here I am", user: user, album: album)
    Fabricate(:album_user, user: user, album: album)
    stub_login_user(user)

    visit album_path(album)

    expect(current_path).to eq(album_path(album))
    expect(page).to have_content("Here I am")

    within ".photo_tile" do
      click_on 'Edit caption'
    end

    expect(current_path).to eq(edit_photo_path(photo))

    fill_in "Caption", with: "I edited this photo"
    click_on "Edit Caption"

    expect(current_path).to eq(album_path(album))

    expect(page).to have_content("I edited this photo")
  end
end
