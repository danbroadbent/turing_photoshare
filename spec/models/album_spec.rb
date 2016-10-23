require 'rails_helper'

RSpec.describe Album, type: :model do
  it { should have_many(:photos) }
  it { should have_many(:comments) }
  it { should have_many(:users) }
  it { should have_many(:album_users) }

  it "returns true if it is private" do
    user = Fabricate(:user)
    private_album = Fabricate(:album, user_id: user.id)
    public_album = Fabricate(:album, public: true, user_id: user.id)

    expect(public_album.private?).to eq(false)
    expect(private_album.private?).to eq(true)
  end

  it "can find all public albums" do
    user = Fabricate(:user)
    private_album = Fabricate(:album, user_id: user.id)
    public_album = Fabricate(:album, public: true, user_id: user.id)

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
    expect(album.display_users.first).to eq(users.first.username)
    expect(album.display_users.last).to eq(users.last.username)
  end
end
