require 'rails_helper'

RSpec.describe Album, type: :model do
  it { should have_many(:photos) }
  it { should belong_to(:user) }

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

end
