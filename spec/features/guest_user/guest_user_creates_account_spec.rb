require 'rails_helper'

RSpec.feature "Guest user creates account" do
  context "user submits the correct 6 digit code" do
    it "shows them their user page" do
      # VCR.use_cassette("create account") do
        visit '/'
        click_on "Create Account"
        fill_in 'Username', with: 'calaway'
        fill_in 'Phone number', with: ENV['MY_PHONE_NUMBER']
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_on 'Create New Account'

        expect(current_path).to eq(new_confirmation_path)
        expect(page).to have_content('Enter 6-digit Code')

        fill_in 'verification_code', with: User.last.verification_code
        click_on 'Submit'

        expect(current_path).to eq(user_path(User.last))
        expect(page).to have_content(User.last.username)
        expect(page).to have_content(ENV['MY_PHONE_NUMBER'])
      end
    # end
  end

  context "user submits an incorrect 6 digit code" do
    it "they are taken back to retry" do
      VCR.use_cassette("do not create account") do
        visit '/'
        click_on "Create Account"
        fill_in 'Username', with: 'calaway'
        fill_in 'Phone number', with: ENV['MY_PHONE_NUMBER']
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_on 'Create New Account'
        fill_in 'verification_code', with: "012345"
        click_on 'Submit'

        expect(page).to have_content('Enter 6-digit Code')
      end
    end
  end
end
