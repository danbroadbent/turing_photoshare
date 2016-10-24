require 'rails_helper'

RSpec.describe "logged in user generates api_token" do
  context "with an email address" do
    scenario "user generates token" do
      user = Fabricate(:user)
      stub_login_user(user)

      visit user_path

      click_on "Generate API Token"
      
      user.reload
      expect(user.api_token.length).to eq(32)
      expect(current_path).to eq(user_path)
      within ".alert" do
        expect(page).to have_content("Your API Token has been emailed to #{user.email}.")
      end
    end
  end

  context "without an email address" do
    scenario "they see an error message" do
      user = Fabricate(:user)
      stub_login_user(user)
      user.user_profile.update(email: nil)

      visit user_path

      click_on "Generate API Token"

      user.reload
      expect(user.api_token).to eq(nil)
      expect(current_path).to eq(user_path)
      within ".alert" do
        expect(page).to have_content("Token Generation Failed! Please add a valid email address.")
      end
    end
  end
end
