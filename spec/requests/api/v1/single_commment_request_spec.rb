require 'rails_helper'

RSpec.describe "Comments CRUD API" do
  it "returns a comment to authenticated user" do
    user = Fabricate(:user, api_token: SecureRandom.hex)
    album = Fabricate(:album)
    Fabricate(:album_user, user: user, album: album)
    comment_1 = Fabricate(:comment, album: album)
    comment_2 = Fabricate(:comment, album: album)

    get "/api/v1/albums/#{album.id}/comments/#{comment_1.id}.json?api_token=#{user.api_token}"

    parsed_comment = JSON.parse(response.body)

    expect(response).to be_success
    expect(parsed_comment.class).to eq(Hash)
    expect(parsed_comment['id']).to eq(comment_1.id)
    expect(parsed_comment['body']).to eq(comment_1.body)
  end

  it "returns 403 if user doesn't have access to the requested album" do
    user = Fabricate(:user, api_token: SecureRandom.hex)
    album = Fabricate(:album)
    comment_1 = Fabricate(:comment, album: album)

    get "/api/v1/albums/#{album.id}/comments/#{comment_1.id}.json?api_token=#{user.api_token}"

    parsed_comment = JSON.parse(response.body)

    expect(response).to have_http_status(:forbidden)
  end

  it "returns 403 if user doesn't have authoized token" do
    user = Fabricate(:user, api_token: SecureRandom.hex)
    album = Fabricate(:album)
    comment_1 = Fabricate(:comment, album: album)

    get "/api/v1/albums/#{album.id}/comments/#{comment_1.id}.json?api_token=777777"

    parsed_comment = JSON.parse(response.body)

    expect(response).to have_http_status(:forbidden)
  end
end
