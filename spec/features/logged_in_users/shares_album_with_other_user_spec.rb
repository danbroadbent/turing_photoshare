require 'rails_helper'

RSpec.feature "Logged in user shares album with other user" do
  scenario "They see both usernames" do
    users = Fabricate.times(2, :user)
    album = Fabricate(:album, user_id: users.first.id)
    Fabricate(:user_profile, user: users.last)
    stub_login_user(users.first)

    visit album_path(album)
    click_link "Share Album"
    fill_in "Username", with: users.last.username
    click_button "Share Album"

    expect(current_path).to eq(album_path(album))
    within ".album" do
      expect(page).to have_content(users.first.username)
      expect(page).to have_content(users.last.username)
    end
    within ".alert" do
      expect(page).to have_content("Successfully shared album '#{album.title}' with '#{users.last.username}'")
    end
  end
end
