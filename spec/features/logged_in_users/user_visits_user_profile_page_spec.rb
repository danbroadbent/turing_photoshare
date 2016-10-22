require 'rails_helper'

RSpec.feature "Logged in user visits user profile page" do
  it "and sees user profile information" do
    user = Fabricate(:user)
    user_2 = Fabricate(:user)
    user_profile = Fabricate(:user_profile, user_id: user.id)
    user_profile_2 = Fabricate(:user_profile, user_id: user_2.id)
    stub_login_user(user)
    visit user_profile_path

    expect(page).to have_link("My Albums")
    expect(page).to have_link("Edit Profile")

    within ".profile" do
      expect(page).to have_content(user_profile.username)
      expect(page).to have_content(user_profile.email)
      expect(page).to have_content(user_profile.bio)

      expect(page).to_not have_content(user_profile_2.username)
      expect(page).to_not have_content(user_profile_2.email)
      expect(page).to_not have_content(user_profile_2.bio)
    end
  end
end
