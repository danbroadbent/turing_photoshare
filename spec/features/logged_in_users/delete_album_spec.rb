require 'rails_helper'

RSpec.feature "user deletes an album they own" do
  scenario "and the album is no longer on their my albums page" do
      user = Fabricate(:user)
      album = Fabricate(:album, user_id: user.id)
      # album_title = album.title
      stub_login_user(user)
      visit album_path(album)

      within ".album-button-bar" do
        click_link "Delete"
      end

      within ".albums" do
        expect(page).to_not have_content(album.title)
      end

      expect(page).to have_content("Album '#{album.title}' has been deleted.")
  end
end
