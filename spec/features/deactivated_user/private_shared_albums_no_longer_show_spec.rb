require 'rails_helper'

RSpec.describe "User with private shared album is deactivated" do
  scenario "that album is no longer viewable by other album users" do
    deactive_user = Fabricate(:user, active: false)
    active_user_1 = Fabricate(:user)
    active_user_2 = Fabricate(:user)

    album_1 = Fabricate(:album)
    album_2 = Fabricate(:album)

    Fabricate(:album_user, user: deactive_user, album: album_1, owner: true)
    Fabricate(:album_user, user: active_user_1, album: album_2, owner: true)

    Fabricate(:album_user, user: active_user_2, album: album_1)
    Fabricate(:album_user, user: active_user_2, album: album_2)

    stub_login_user(active_user_2)
    visit my_albums_path

    expect(page).to have_content(album_2.title)
    expect(page).to_not have_content(album_1.title)

    visit album_path(album_1)
    
    expect(current_path).to eq(my_albums_path)
    expect(page).to have_content("The album you are looking for belongs to an inactive user and is no longer accessible.")
  end
end
