require 'rails_helper'

RSpec.feature "User can modify comments"  do
  scenario "User creates comment, and deletes it" do
    user = Fabricate(:user)
    album = Fabricate(:album)
    Fabricate(:album_user, user: user, album: album)
    stub_login_user(user)

    visit album_path(album)

    fill_in 'Comment', with: 'sup sup'
    click_on 'Add Comment'

    expect(page).to have_content('sup sup')

    within ".comment_tile" do
      first('.delete-button').click
    end

    expect(current_path).to eq(album_path(album))
    expect(page).to_not have_content('sup sup')
  end

  scenario "User edits comment" do
    user = Fabricate(:user)
    album = Fabricate(:album)
    Fabricate(:album_user, user: user, album: album)
    stub_login_user(user)

    visit album_path(album)

    fill_in 'Comment', with: 'sup sup'
    click_on 'Add Comment'

    expect(page).to have_content('sup sup')

    within ".comment_tile" do
      first('.edit-button').click
    end

    fill_in "Comment", with: 'back again'
    click_on 'Update Comment'

    expect(page).to have_content("back again")
    expect(page).to_not have_content("sup sup")
  end
end
