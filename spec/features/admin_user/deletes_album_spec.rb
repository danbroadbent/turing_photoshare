require 'rails_helper'

RSpec.feature "Admin user visits album dashboard" do
  scenario "sees all albums and can delete a single album" do
    album = Fabricate(:album)
    stub_login_user Fabricate(:user, role: 1)

    visit admin_albums_path
    expect(page).to have_css("tr", count: 2)

    first('.delete-button').click
    expect(current_path).to eq(admin_albums_path)
    expect(page).to have_css("tr", count: 1)
    expect(page).to_not have_content(album.title)
  end
end
