require 'rails_helper'

RSpec.feature "Admin user visits user dashboard" do
  xscenario "sees all users and can edit a single user" do
    user = Fabricate(:user)
    stub_login_user Fabricate(:user, role: 1)

    visit admin_albums_path
    expect(page).to have_css("tr", count: 2)
    expect(page).to have_content("My greatest album")

    first('.edit-button').click
    expect(current_path).to eq(edit_album_path(album))

    fill_in "Title", with: "My greatest album edited"
    click_button "Update"

    expect(current_path).to eq(album_path(album))
    expect(page).to have_content("My greatest album edited")
  end
end
