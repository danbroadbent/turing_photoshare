require 'rails_helper'

RSpec.feature "Admin user visits album dashboard" do
  scenario "sees all albums and can edit a single album" do
    album = Fabricate(:album, title: "My greatest album")
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
