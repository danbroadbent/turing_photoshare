require 'rails_helper'

RSpec.feature "User can delete own comments"  do
  scenario "User creates comment, and deletes it" do
    # As a registered user
    user = Fabricate(:user)
    album = Fabricate(:album, user_id: user.id)
    # photo = Fabricate(:photo, album_id: album.id, user_id: user.id)

    stub_login_user(user)
    # when I visit an album page,
    visit "/albums/#{album.id}"
    # and I make a comment,
    fill_in 'Comment', with: 'sup sup'
    click_on 'Add Comment'

    expect(page).to have_content('sup sup')

    within ".comment_tile" do
      click_on "Delete Comment"
    end

    # I see buttons to edit and delete the comment

    expect(current_path).to eq("/albums/#{album.id}")
    expect(page).to_not have_content('sup sup')
  end
end
