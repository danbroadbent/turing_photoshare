require 'rails_helper'

RSpec.feature "logged in user edits album" do
  scenario "and changes permission from private to public" do
    album = Fabricate(:album)
    stub_login_user Fabricate(:user)
    Fabricate(:album_user, album: album, user: User.first)

    visit album_path(album)
    expect(current_path).to eq(album_path(album))

    click_link "Edit Album"
    expect(current_path).to eq(edit_album_path(album))

    first('input#hidden-permission', visible: false).set(true)
    click_button "Update"
    
    expect(current_path).to eq(album_path(album))
    expect(page).to have_content("Permissions: Public")
  end
end
