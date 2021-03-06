require 'rails_helper'

RSpec.feature "Guest user visits home page" do
  it "and sees public albums" do
    user = Fabricate(:user)
    public_album = Fabricate(:album, public: true)
    public_album.users << user
    Fabricate( :photo,
               album_id: public_album.id,
               user_id: user.id,
               image: File.open(File.join(Rails.root, "spec/fixtures/dummy.png"))
             )

    visit root_path

    expect(page).to have_link(public_album.title)
    expect(page).to_not have_content("Create Album")
    within ".photo_tile" do
      expect(page).to have_css("img")
      expect(page).to have_content(public_album.description.split()[0..3].join(" "))
    end
  end

  it "and does not see private content" do
    user = Fabricate(:user)
    public_album = Fabricate(:album)
    Fabricate( :photo,
               album_id: public_album.id,
               user_id: user.id,
               image: File.open(File.join(Rails.root, "spec/fixtures/dummy.png"))
             )

    visit root_path

    expect(page).to_not have_link(public_album.title)
    expect(page).to_not have_css(".photo_tile")
  end
end
