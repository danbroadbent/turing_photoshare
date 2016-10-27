require 'rails_helper'

RSpec.feature "Admin user visits user dashboard" do
  scenario "sees all users and can delete a single user" do
    user = Fabricate(:user)
    Fabricate(:user_profile, user: user)
    stub_login_user Fabricate(:user, role: 1)
    owned_album = Fabricate(:album)
    shared_album = Fabricate(:album)
    Fabricate(:album_user, album: owned_album, user: user, owner: true)
    Fabricate(:album_user, album: shared_album, user: user)

    visit admin_albums_path
    expect(page).to have_css("tr", count: 3)

    visit admin_users_path
    expect(page).to have_css("tr", count: 3)

    first('.delete-button').click
    expect(current_path).to eq(admin_users_path)
    expect(page).to have_css("tr", count: 2)
    expect(page).to_not have_content(user.username)

    visit admin_albums_path
    expect(page).to have_css("tr", count: 2)
  end
end
