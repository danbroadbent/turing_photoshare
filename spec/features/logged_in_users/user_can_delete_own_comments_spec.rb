require 'rails_helper'

RSpec.feature "User can delete own comments"  do
  scenario "User creates comment, and deletes it" do
    user = Fabricate(:user)
    album = Fabricate(:album, user_id: user.id)
    stub_login_user(user)

    visit "/albums/#{album.id}"

    fill_in 'Comment', with: 'sup sup'
    click_on 'Add Comment'

    expect(page).to have_content('sup sup')

    within ".comment_tile" do
      click_on "Delete Comment"
    end

    expect(current_path).to eq("/albums/#{album.id}")
    expect(page).to_not have_content('sup sup')
  end

  scenario "User edits comment" do
    user = Fabricate(:user)
    album = Fabricate(:album, user_id: user.id)
    stub_login_user(user)

    visit "/albums/#{album.id}"

    fill_in 'Comment', with: 'sup sup'
    click_on 'Add Comment'

    expect(page).to have_content('sup sup')

    within ".comment_tile" do
      click_on "Edit Comment"
    end

    fill_in "Comment", with: 'back again'
    click_on 'Update Comment'

    expect(page).to have_content("back again")
    expect(page).to_not have_content("sup sup")
  end
end
