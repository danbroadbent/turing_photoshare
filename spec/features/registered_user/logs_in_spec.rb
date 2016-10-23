require 'rails_helper'

RSpec.feature "Registered user logs in" do
  context "Registered user logs in" do
    it "shows them their user page" do
      user = Fabricate(:user)
      Fabricate(:user_profile, user: user)
      visit '/'
      click_on "Login"
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_on "Submit"
      expect(current_path).to eq(new_confirmation_path)
      expect(page).to have_content("Enter 6-digit Code")
      fill_in "verification_code", with: user.verification_code
      click_on "Submit"
      expect(current_path).to eq(user_path(user))
      expect(page).to have_content(user.username)
      expect(page).to have_content("Logout")
    end
  end
end