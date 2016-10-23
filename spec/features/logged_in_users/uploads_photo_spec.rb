require 'rails_helper'

RSpec.feature "user uploads photo" do
  scenario "from album page" do
      user = Fabricate(:user)
      album = Fabricate(:album, user_id: user.id)
      stub_login_user(user)
      visit album_path(album)
      click_link "Add Photo"
      expect(current_path).to eq(new_photo_path)

      fill_in "Caption", with: "My photo caption."
      attach_file("Image", Rails.root + "spec/fixtures/dummy.png")
      click_button "Upload"

      expect(current_path).to eq(album_path(album))
      within ".photo_tile" do
        expect(page).to have_content("My photo caption.")
        expect(page).to have_content(user.username)
        expect(page).to have_css("img")
    end
  end
end
