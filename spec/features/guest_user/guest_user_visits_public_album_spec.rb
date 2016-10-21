require 'rails_helper'

RSpec.feature "Guest user visits album page" do
  it "and sees all of the album's contents" do
    user = Fabricate(:user)
    public_album = Fabricate(:album, public: true, user_id: user.id)
    Fabricate( :photo,
               album_id: public_album.id,
               user_id: user.id,
               image: File.open(File.join(Rails.root, "spec/fixtures/dummy.png"))
             )

    visit album_path(public_album)
    save_and_open_page
    within ".photo_tile" do
      expect(page).to have_content(public_album.user.username)
      expect(page).to have_css("img")
      expect(page).to have_content(public_album.photos.first.caption)
    end
  end
end
