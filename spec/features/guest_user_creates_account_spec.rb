require 'rails_helper'

RSpec.feature "Guest user creates account" do
  scenario "through two factor authenitcation" do
    # When a guest user visits the root,
    visit '/'
    # And clicks "create account"
    click_on "Create Account"
    # And fills in username
    fill_in 'Username', with: 'calaway'
    # And fills in cell phone
    fill_in 'Phone number', with: ENV['MY_PHONE_NUMBER']
    # And fills in password
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    # And they click "create account"
    click_on 'Create New Account'
    # They will see a two factor authentication page
    expect(current_path).to eq(new_confirmation_path)
    expect(page).to have_content('Enter 6-digit Code')
    # And they fill in the texted password
    fill_in 'verification_code', with: User.last.verification_code
    # And they click "Submit"
    click_on 'Submit'
    # Then they will see their profile page
    expect(current_path).to eq(user_path(User.last))
    expect(page).to have_content(User.last.username)
  end
end
