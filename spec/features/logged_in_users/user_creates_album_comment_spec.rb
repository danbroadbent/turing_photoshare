require 'rails_helper'

RSpec.feature "User adds comment to album" do
  scenario "logged in user comments on album" do
    user = Fabricate(:user)
    album = Fabricate(:album)
    stub_login_user(user)
    visit '/albums/1'
    fill_in 'Comment', with: 'hello world'
    click_on 'Add Comment'
    expect(current_path).to eq('/albums/1')
    expect(page).to have_content('hello world')
    expect(page).to have_content(user.username)
    expect(page).to have_content(Comment.last.created_at)
  end
end
