require 'rails_helper'

RSpec.describe "User with private shared album is deactivated" do
  scenario "that album is no longer viewable by other album users" do
    deactive_user = Fabricate(:user, active: false)
    active_user = Fabricate(:user)
    album = Fabricate(:album)
    Fabricate(:album_user,
              user: deactive_user,
              album: album,
              owner: true)
    Fabricate(:album_user,
              user: active_user,
              album: album)
    binding.pry
    stub_login_user(active_user)
    visit my_albums_path
    expect(page).to_not have_content(album.title)

    visit album_path(album)
    expect(current_path).to eq(albums_path)
    expect(page).to have_content("The album you are looking for belongs to an inactive user and is no longer accessible.")
  end
end
