require 'rails_helper'

RSpec.feature "Admin user visits users dashboard" do
  scenario "and can edit a single album" do
    user = Fabricate(:user)
    Fabricate(:user_profile, user: user)
    stub_login_user Fabricate(:user, role: 1)

    visit admin_users_path
    expect(page).to have_css("tr", count: 3)
    expect(page).to have_content(user.username)

    first('.edit-button').click
    expect(current_path).to eq(edit_admin_user_path(user))

    first('input#hidden-status', visible: false).set(false)
    click_button "Update"

    expect(current_path).to eq(admin_user_path(user))
    expect(page).to have_content("Status: Inactive")
  end
end
