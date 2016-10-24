require 'rails_helper'

RSpec.feature "user creates private album" do
  scenario "from album new page" do
    user = Fabricate(:user)
    stub_login_user(user)
    visit albums_path
    click_link "Create Album"
    fill_in "Title", with: "My Album Title"
    fill_in "Description", with: "My album description."
    click_button "Create"

    expect(current_path).to eq(album_path(Album.first))
    expect(page).to have_content("My Album Title")
    expect(page).to have_content("My album description.")
  end
end
