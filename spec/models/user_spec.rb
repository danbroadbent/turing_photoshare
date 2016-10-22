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
end
