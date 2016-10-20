require 'rails_helper'

RSpec.feature "Registered user logs in" do
  context "Registered user logs in" do
    it "shows them their user page" do
      # As a not logged in registered user,
      user = Fabricate(:user)
      # visits root,
      visit '/'
      # and clicks login,
      click_on "Login"
      # and enters username and password
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      # and clicks submit
      click_on "Submit"
      # then enters 6 digit code
      expect(current_path).to eq(new_confirmation_path)
      expect(page).to have_content("Enter 6-digit Code")

      fill_in "verification_code", with: user.verification_code

      click_on "Submit"

      expect(current_path).to eq(user_path(user))
      expect(page).to have_content(user.username)
      expect(page).to have_content("Logout")
      # and clicks submit
      # then sees username and 'logout' button on the nav bar
    end
  end
end
