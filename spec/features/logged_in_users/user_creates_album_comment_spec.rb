require 'rails_helper'

RSpec.feature "User adds comment to album" do
  scenario "logged in user comments on album" do
    user = Fabricate(:user)
    album = Fabricate(:album, user_id: user.id)
    stub_login_user(user)

    visit "/albums/#{album.id}"
    fill_in 'Comment', with: 'hello world'
    click_on 'Add Comment'

    expect(current_path).to eq("/albums/#{album.id}")
    expect(page).to have_content('hello world')
    expect(page).to have_content(user.username)
    expect(page).to have_content(Comment.last.created_at)
  end
end
