require 'rails_helper'

RSpec.feature "Guest user visits home page" do
  scenario "and sees guest user navigation bar" do
    visit root_path
    within ".nav" do
      expect(page).to have_link("Login")
      expect(page).to have_link("Create Account")
      expect(page).to_not have_link("Logout")
      expect(page).to_not have_link("My Albums")
      expect(page).to_not have_link("Admin dashboard")
    end
  end
end
