require 'rails_helper'

RSpec.feature "Logged in user visits home page" do
  scenario "and sees logged in user navigation bar" do
    stub_login_user Fabricate(:user)
    visit root_path
    within ".nav" do
      expect(page).to have_link("My Albums")
      expect(page).to have_link("Profile")
      expect(page).to have_link("Logout")
      expect(page).to_not have_link("Login")
      expect(page).to_not have_link("Create Account")
      expect(page).to_not have_link("Admin dashboard")
    end
  end
end
