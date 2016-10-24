require 'rails_helper'

RSpec.describe "Comments CRUD API" do
  it "returns a list of comments to authnticated user" do
    user = Fabricate(:user, api_token: '12345')
    album = Fabricate(:album)
    Fabricate(:album_user, user: user, album: album)
    comment_1 = Fabricate(:comment, album_id: album.id, user: user)
    comment_2 = Fabricate(:comment, album_id: album.id, user: user)

    get "/api/v1/albums/#{album.id}/comments.json?api_token=#{user.api_token}"

    parsed_comments = JSON.parse(response.body)

    expect(response).to be_success
    expect(parsed_comments.count).to eq(2)
  end

  it "fails to return list if Unauthorized" do
    user = Fabricate(:user, api_token: "435342")
    album = Fabricate(:album)
    Fabricate(:album_user, user: user, album: album)
    comment_1 = Fabricate(:comment, album_id: album.id, user: user)
    comment_2 = Fabricate(:comment, album_id: album.id, user: user)

    get "/api/v1/albums/#{album.id}/comments.json?api_token=93h4573"

    parsed_comments = JSON.parse(response.body)

    expect(response.status).to be(404)
  end
end
