require 'rails_helper'

RSpec.feature "When a logged in user clicks logout" do
  scenario "they are logged out" do
    user = Fabricate(:user)
    stub_login_user(user)

    click_on "Logout"
    expect(current_path).to eq(albums_path)
    expect(page).to have_content("Login")
  end
end
