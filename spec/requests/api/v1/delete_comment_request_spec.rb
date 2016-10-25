require 'rails_helper'

RSpec.describe "Comments edit" do
  it "edits a comment on an album" do
    user = Fabricate(:user, api_token: SecureRandom.hex)
    album = Fabricate(:album)
    Fabricate(:album_user, user: user, album: album)
    comment = Fabricate(:comment, album: album)

    delete "/api/v1/albums/#{album.id}/comments/#{comment.id}.json?api_token=#{user.api_token}"

    expect(response.status).to eq(204)
    expect(response['body']).to eq(nil)
    expect(Comment.count).to eq(0)
  end

  it "edits a comment on an album with wrong token" do
    user = Fabricate(:user, api_token: SecureRandom.hex)
    album = Fabricate(:album)
    Fabricate(:album_user, user: user, album: album)
    comment = Fabricate(:comment, album: album)

    delete "/api/v1/albums/#{album.id}/comments/#{comment.id}.json?api_token=#{SecureRandom.hex}"

    expect(response.status).to eq(403)
  end
end
