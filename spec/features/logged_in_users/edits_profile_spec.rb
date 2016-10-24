require 'rails_helper'

RSpec.feature "User edits their profile" do
  scenario "and changes are visible on profile page" do
    user = Fabricate(:user)
    stub_login_user(user)
    original_email = user.user_profile.email
    original_phone = user.phone_number
    visit user_path

    click_link 'Edit profile'
    fill_in 'Phone number', with: "5555555555"
    fill_in 'Email', with: "#{user.username}@example.com"
    fill_in 'Bio', with: "Here is my life story!"
    click_button 'Update'

    within ".profile" do
      expect(page).to have_content(user.username)
      expect(page).to have_content("#{user.username}@example.com")
      expect(page).to have_content("5555555555")
      expect(page).to have_content("Here is my life story!")

      expect(page).to_not have_content(original_email)
      expect(page).to_not have_content(original_phone)
    end
  end
end
