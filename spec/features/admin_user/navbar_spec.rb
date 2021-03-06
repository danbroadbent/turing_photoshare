require 'rails_helper'

RSpec.feature "Admin user visits home page" do
  scenario "and sees admin user navigation bar" do
    stub_login_user Fabricate(:user, role: 1)
    visit root_path
    within ".nav" do
      expect(page).to have_link("Admin dashboard")
      expect(page).to have_link("My Albums")
      expect(page).to have_link("Profile")
      expect(page).to have_link("Logout")
      expect(page).to_not have_link("Login")
      expect(page).to_not have_link("Create Account")
    end
  end
end
