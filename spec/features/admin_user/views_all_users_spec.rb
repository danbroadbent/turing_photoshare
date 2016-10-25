require 'rails_helper'

RSpec.feature "Admin user visits album dashboard" do
  scenario "sees all albums and individual album page" do
    user = Fabricate(:user)
    user_profile = Fabricate(:user_profile, user: user)
    stub_login_user Fabricate(:user, role: 1)

    visit dashboard_path

    click_link "All Users"

    expect(current_path).to eq(admin_users_path)
    expect(page).to have_css("tr", count: 3)
    click_link user.username

    expect(current_path).to eq(admin_user_path(user))
    expect(page).to have_content(user.username)
    expect(page).to have_content(user.email)
    expect(page).to have_content(user.phone_number)
    expect(page).to have_content(user.user_profile.bio)
  end
end
