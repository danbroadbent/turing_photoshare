require 'rails_helper'

RSpec.feature "Registered user logs in" do
  context "they submit the correct confirmation code" do
    it "shows them their user page" do
      VCR.use_cassette "login" do
        user = Fabricate(:user)
        Fabricate(:user_profile, user: user)
        visit root_path
        click_on "Login"
        fill_in "Username", with: user.username
        fill_in "Password", with: user.password
        click_on "Submit"
        previous_verification_code = user.verification_code

        expect(current_path).to eq(new_confirmation_path)
        expect(page).to have_content("Enter 6-digit Code")

        user.reload
        fill_in "verification_code", with: user.verification_code
        click_on "Submit"

        expect(user.verification_code).to_not eq(previous_verification_code)
        expect(current_path).to eq(user_path(user))
        expect(page).to have_content(user.username)
        expect(page).to have_content("Logout")
      end
    end
  end

  context "submit incorrect password" do
    it "routes them back to retry" do
      user = Fabricate(:user)
      Fabricate(:user_profile, user: user)
      visit login_path
      fill_in "Username", with: user.username
      fill_in "Password", with: "GobbldyGook"
      click_on "Submit"

      expect(current_path).to eq(login_path)
      within ".nav" do
        expect(page).to have_content('Create Account')
      end
      within ".alert" do
        expect(page).to have_content('Invalid Username or Password')
      end
    end
  end

  context "don't submit a confirmation code" do
    it "redirects them to root" do
      VCR.use_cassette "login sad path" do
        user = Fabricate(:user)
        Fabricate(:user_profile, user: user)
        visit login_path
        fill_in "Username", with: user.username
        fill_in "Password", with: user.password
        click_on "Submit"
        visit my_albums_path

        expect(current_path).to eq(root_path)
        within ".nav" do
          expect(page).to have_content('Create Account')
        end
      end
    end
  end

  context "after 3 bad confirmations" do
    it "resets the confirmation code and sends a new text" do
      visit login_path
      
    end
  end
end
