require 'rails_helper'

RSpec.feature 'user can download a zip of album photos' do
  scenario 'user hits download album button on album' do
    user = Fabricate(:user)
    album = Fabricate(:album)
    Fabricate(:photo, album_id: album.id, user_id: user.id)
    album_user = Fabricate(:album_user, user: user, album: album)
    Fabricate(:user_profile, user: user)
    stub_login_user(user)

    visit album_path(album)

    click_on 'Download Album'
  end
end
