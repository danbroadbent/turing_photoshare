require 'rails_helper'

RSpec.feature "Logged in user visits public album" do
  scenario "does not see upload photo button" do
    user = Fabricate(:user)
    album = Fabricate(:album, public: true)
    stub_login_user(user)

    visit album_path(album)

    expect(page).to_not have_link("Add Photo")
  end
end
