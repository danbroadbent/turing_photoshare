require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:albums) }
  it { should have_many(:photos) }
  it { should have_one(:user_profile) }

  it "has a username" do
    user = Fabricate(:user)
    
    user_profile = Fabricate(:user_profile, user: user)

    expect(user.username).to eq(user.user_profile.username)
  end

  it "has a phone number" do
    user = Fabricate(:user)
    user_profile = Fabricate(:user_profile, user: user)

    expect(user.phone_number).to eq(user.user_profile.phone_number)
  end

  it "can be found by username" do
    user_new = Fabricate(:user)
    another_user = Fabricate(:user)
    user_profile = Fabricate(:user_profile, user: user_new)

    user = User.find_by_username(user_new.username)
    expect(user).to eq(user_new)
    expect(user).to_not eq(another_user)
  end
end
