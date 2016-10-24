require 'rails_helper'

RSpec.feature "Logged in user visits private album path they aren't invited to" do
  scenario "they're redirected to the home page" do
    user = Fabricate(:user)
    album = Fabricate(:album)
    stub_login_user(user)

    visit album_path(album)

    expect(current_path).to eq(root_path)
  end
end
