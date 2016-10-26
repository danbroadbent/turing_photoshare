require 'rails_helper'

RSpec.feature "Registered user visits home page" do
  it "and sees public albums" do
    user = Fabricate(:user)
    public_album = Fabricate(:album, public: true)
    public_album.users << Fabricate(:user)
    private_album = Fabricate(:album, public: false)
    private_album.users << Fabricate(:user)
    stub_login_user(user)

    visit root_path

    expect(page).to     have_link(public_album.title)
    expect(page).to_not have_link(private_album.title)
  end
end
