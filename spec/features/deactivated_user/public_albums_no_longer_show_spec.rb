require 'rails_helper'

RSpec.describe "User with public album is deactivated" do
  scenario "that album no longer shows" do
    user_to_be_deactivated = Fabricate(:user, active: true)
    public_album = Fabricate(:album, public: true)
    album_user = Fabricate(:album_user,
                            user: user_to_be_deactivated,
                            album: public_album,
                            owner: true)
    Fabricate(:album, public: true).users << Fabricate(:user)
    Fabricate(:album, public: false).users << Fabricate(:user)

    visit root_path

    expect(page).to have_link(public_album.title)
    expect(page).to have_css(".photo_tile", count: 2)

    user_to_be_deactivated.update(active: false)
    visit root_path

    expect(page).to_not have_link(public_album.title)
    expect(page).to have_css(".photo_tile", count: 1)
  end
end
