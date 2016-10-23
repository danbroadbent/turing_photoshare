require 'rails_helper'

RSpec.feature "Logged in visits my albums path" do
  scenario "they see all albums they've uploaded" do
    # As a logged in user
    user = Fabricate(:user)
    albums = Fabricate.times(2, :album, user_id: user.id)
    stub_login_user(user)
    # when I visit the my albums path
    visit my_albums_path
    # then I see all albums I've created
    expect(page).to have_content(albums.first.title)
    expect(page).to have_content(albums.last.title)
  end

  scenario "they see all albums they've been invited to" do
    # and I see all albums I've been invited to
  end
end
