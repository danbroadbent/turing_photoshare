require 'rails_helper'

RSpec.describe UserProfile, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }

  context "#user" do
    it "returns the associated user object" do
      user = Fabricate(:user)
      user_profile = Fabricate(:user_profile, user: user)

      expect(user_profile.user).to eq(user)
    end
  end
end
