require 'rails_helper'

RSpec.describe Album, type: :model do
  it { should have_many(:photos) }
  it { should have_many(:comments) }
  it { should have_many(:users) }
  it { should have_many(:album_users) }

  it "returns true if it is private" do
    private_album = Fabricate(:album)
    public_album = Fabricate(:album, public: true)

    expect(public_album.private?).to eq(false)
    expect(private_album.private?).to eq(true)
  end

  it "can find all public albums" do
    private_album = Fabricate(:album)
    public_album = Fabricate(:album, public: true)
    Fabricate(:user).albums.push(private_album, public_album)

    expect(Album.find_all_public.count).to eq(1)
    expect(Album.find_all_public.first).to eq(public_album)
  end

  it "can display all users" do
    users = Fabricate.times(2, :user)
    Fabricate(:user_profile, user: users.first)
    Fabricate(:user_profile, user: users.last)
    album = Fabricate(:album)
    album_user_1 = Fabricate(:album_user, user: users.first, album: album)
    album_user_2 = Fabricate(:album_user, user: users.last, album: album)

    expect(album.display_users.count).to eq(2)
    expect(album.display_users).to include(users.first.username)
    expect(album.display_users).to include(users.last.username)
  end

  it "knows if a user has editing rights" do
    authorized_users = Fabricate.times(2, :user)
    unauthorized_user = Fabricate(:user)
    album = Fabricate(:album)
    album_user_1 = Fabricate(:album_user, user: authorized_users.first, album: album, owner: true)
    album_user_2 = Fabricate(:album_user, user: authorized_users.last, album: album, owner: false)

    expect(album.permitted?(authorized_users.first)).to eq(true)
    expect(album.permitted?(authorized_users.last)).to eq(true)
    expect(album.permitted?(unauthorized_user)).to eq(false)
  end

  it "knows if it is public or private" do
    album_1 = Fabricate(:album, public: false)
    album_2 = Fabricate(:album, public: true)

    expect(album_1.permissions).to eq("Private")
    expect(album_2.permissions).to eq("Public")
  end

  it "can be scoped to albums belonging to active users" do
    album_1 = Fabricate(:album)
    album_2 = Fabricate(:album)

    user_1 = Fabricate(:user, active: false)
    Fabricate(:album_user, user: user_1, album: album_1, owner: true)
    binding.pry
    expect(Album.count).to eq(2)
    expect(Album.active.count).to eq(1)
    expect(Album.active.first).to eq(album_2)
  end
end
