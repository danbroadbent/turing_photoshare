require 'rails_helper'

RSpec.feature "When a logged in user clicks logout" do
  scenario "they are logged out" do
    stub_login_user Fabricate(:user)

    click_link "Logout"

    expect(current_path).to eq(albums_path)

    within ".nav" do
      expect(page).to have_link("Login")
      expect(page).to have_link("Create Account")
      expect(page).to_not have_link("Logout")
      expect(page).to_not have_link("My Albums")
      expect(page).to_not have_link("Admin dashboard")
    end
  end
end
