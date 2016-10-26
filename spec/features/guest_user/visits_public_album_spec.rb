require 'rails_helper'

RSpec.feature "Guest user visits a public album page" do
  it "and sees all of the album's contents" do
    user = Fabricate(:user)
    Fabricate(:user_profile, user: user)
    public_album = Fabricate(:album, public: true)
    Fabricate( :photo,
               album_id: public_album.id,
               user_id: user.id,
               image: File.open(File.join(Rails.root, "spec/fixtures/dummy.png"))
             )

    visit album_path(public_album)

    within ".photo_tile" do
      expect(page).to have_css("img")
      expect(page).to have_content(public_album.description)
    end
  end
end
