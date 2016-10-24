require 'rails_helper'

RSpec.describe "logged in user generates api_token" do
  scenario "user generates token" do
    user = Fabricate(:user)
    stub_login_user(user)

    visit '/profile'
    click_on "Edit profile"

    click_on "Generate token"

    expect(User.last.api_token.length).to eq(32)
  end
end
