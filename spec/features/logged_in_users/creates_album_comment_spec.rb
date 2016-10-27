require 'rails_helper'

RSpec.feature "User adds comment to album" do
  scenario "logged in user comments on album" do
    user = Fabricate(:user)
    album = Fabricate(:album)
    Fabricate(:album_user, user: user, album: album, owner: true)
    stub_login_user(user)

    visit "/albums/#{album.id}"
    fill_in 'Comment', with: 'hello world'
    click_on 'Add Comment'

    expect(current_path).to eq("/albums/#{album.id}")
    expect(page).to have_content('hello world')
    expect(page).to have_content(user.username)
    expect(page).to have_content("Created: less than a minute ago")
  end
end
