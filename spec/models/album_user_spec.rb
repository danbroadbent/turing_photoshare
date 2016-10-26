require 'rails_helper'

RSpec.describe AlbumUser, type: :model do
  it { should belong_to(:album) }
  it { should belong_to(:user) }

  it "can return all album users that refer to ownership relationship" do
    expected = Fabricate(:album_user, owner: true)
    Fabricate(:album_user)

    expect(AlbumUser.count).to eq(2)
    expect(AlbumUser.owned.count).to eq(1)
    expect(AlbumUser.owned.first).to eq(expected)
  end

  it "can return all album users of active users" do
    active_user = Fabricate(:user, active: true)
    deactive_user = Fabricate(:user, active: false)


    active = Fabricate(:album_user, user: active_user)
    Fabricate(:album_user, user: deactive_user)

    expect(AlbumUser.count).to eq(2)
    expect(AlbumUser.active.count).to eq(1)
    expect(AlbumUser.active.first).to eq(active)
  end

  it "can return all the owned album users of active users" do
    active_user = Fabricate(:user, active: true)
    deactive_user = Fabricate(:user, active: false)

    album_1 = Fabricate(:album)
    album_2 = Fabricate(:album)

    Fabricate(:album_user, album: album_1, user: active_user, owner: true)
    Fabricate(:album_user, album: album_2, user: active_user)
    Fabricate(:album_user, album: album_2, user: deactive_user, owner: true)
    Fabricate(:album_user, album: album_1, user: deactive_user)

    expected = AlbumUser.first

    expect(AlbumUser.count).to eq(4)
    expect(AlbumUser.owned_active.count).to eq(1)
    expect(AlbumUser.owned_active.first).to eq(expected)
  end
end
