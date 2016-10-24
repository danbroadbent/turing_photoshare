require 'rails_helper'

RSpec.feature "Logged in user visits user profile page" do
  it "and sees user profile information" do
    user = Fabricate(:user)
    user_2 = Fabricate(:user)
    user_profile_2 = Fabricate(:user_profile,
                                user: user_2,
                                email: 'email@turing.io',
                                bio: 'my life story!')

    stub_login_user(user)
    visit user_path

    expect(page).to have_link("My Albums")
    expect(page).to have_link("Edit profile")

    within ".profile" do
      expect(page).to have_content(user.username)
      expect(page).to have_content(user.user_profile.email)
      expect(page).to have_content(user.user_profile.bio)

      expect(page).to_not have_content(user_profile_2.username)
      expect(page).to_not have_content(user_profile_2.email)
      expect(page).to_not have_content(user_profile_2.bio)
    end
  end
end
