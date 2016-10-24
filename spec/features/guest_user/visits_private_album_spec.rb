require 'rails_helper'

RSpec.feature "Guest user visits a private album page" do
  it "and is redirected to the login page" do
    user = Fabricate(:user)
    private_album = Fabricate(:album)
    Fabricate( :photo,
               album_id: private_album.id,
               user_id: user.id,
               image: File.open(File.join(Rails.root, "spec/fixtures/dummy.png"))
             )

    visit album_path(private_album)

    expect(current_path).to eq(albums_path)

  end
end
