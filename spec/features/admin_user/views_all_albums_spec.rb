require 'rails_helper'

RSpec.feature "Admin user visits album dashboard" do
  scenario "and clicks a private album link, and visits that album page" do
    album = Fabricate(:album)
    stub_login_user Fabricate(:user, role: 1)

    visit dashboard_path

    click_link "All Albums"

    expect(current_path).to eq(admin_albums_path)
    expect(page).to have_css("tr", count: 2)
    click_link album.title

    expect(current_path).to eq(album_path(album))
    expect(page).to have_content(album.title)
    expect(page).to have_content(album.description)
  end
end
