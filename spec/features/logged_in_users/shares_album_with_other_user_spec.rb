require 'rails_helper'

RSpec.feature "Logged in user shares album with other user" do
  scenario "They see both usernames" do
    users = Fabricate.times(2, :user)
    album = Fabricate(:album)
    album_user_1 = Fabricate(:album_user,
                              user: users.first,
                              album: album,
                              owner: true)
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

  context "they submit an invalid username" do
    scenario "the album is not shared" do
      users = Fabricate.times(2, :user)
      album = Fabricate(:album)
      album_user_1 = Fabricate(:album_user,
                                user: users.first,
                                album: album,
                                owner: true)
      Fabricate(:user_profile, user: users.last)
      stub_login_user(users.first)

      visit album_path(album)
      click_link "Share Album"
      fill_in "Username", with: "Bob_Ross"
      click_button "Share Album"

      within ".album" do
        expect(page).to_not have_content(users.last.username)
      end
      within ".alert" do
        expect(page).to have_content("Sharing album failed! Please try again with a valid recipent username")
      end
      expect(AlbumUser.count).to eq(1)
    end
  end
end
