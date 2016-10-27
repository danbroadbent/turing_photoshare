require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:album_users) }
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

  it "knows if it is inactive" do
    user = Fabricate(:user, active: false)
    expect(user.inactive?).to eq(true)
  end

  it "has a status of inactive if it is inactive" do
    user = Fabricate(:user, active: false)
    expect(user.status).to eq("Inactive")

    user = Fabricate(:user)
    expect(user.status).to eq("Active")
  end

  it "can return only active users" do
    user = Fabricate(:user, active: true)
    Fabricate(:user, active: false)

    expect(User.count).to eq(2)
    expect(User.active.count).to eq(1)
    expect(User.active.first).to eq(user)
  end

  it "can find all shared and owned albums scoped to active users" do
    deactive_user = Fabricate(:user, active: false)
    active_user_1 = Fabricate(:user)
    active_user_2 = Fabricate(:user)

    album_1 = Fabricate(:album)
    album_2 = Fabricate(:album)
    album_3 = Fabricate(:album)

    Fabricate(:album_user, user: deactive_user, album: album_1, owner: true)
    Fabricate(:album_user, user: active_user_1, album: album_2, owner: true)
    Fabricate(:album_user, user: active_user_2, album: album_3, owner: true)

    Fabricate(:album_user, user: active_user_2, album: album_1)
    Fabricate(:album_user, user: active_user_2, album: album_2)

    expect(active_user_2.active_albums.count).to eq(2)
    expect(active_user_2.active_albums.first).to eq(album_2)
    expect(active_user_2.active_albums.last).to eq(album_3)
  end
end
