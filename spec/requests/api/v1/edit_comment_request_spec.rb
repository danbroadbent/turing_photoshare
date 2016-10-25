require 'rails_helper'

RSpec.describe "Comments edit" do
  it "edits a comment on an album" do
    user = Fabricate(:user, api_token: '12345')
    album = Fabricate(:album)
    Fabricate(:album_user, user: user, album: album)
    comment = Fabricate(:comment, album: album)

    params = { body: 'this comment is soo cool'}
    patch "/api/v1/albums/#{album.id}/comments/#{comment.id}.json?api_token=#{user.api_token}", params.to_json, { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    comment_response = JSON.parse(response.body)

    expect(response.status).to eq(200)
    expect(comment_response['body']).to eq('this comment is soo cool')
    expect(comment_response['user_id']).to eq(user.id)
    expect(comment_response['album_id']).to eq(album.id)
    expect(Comment.all.count).to eq(1)
    expect(Comment.first.body).to eq('this comment is soo cool')
  end

  it "fail to edit a comment on an album with incorrect token" do
    user = Fabricate(:user, api_token: '12345')
    album = Fabricate(:album)
    Fabricate(:album_user, user: user, album: album)
    comment = Fabricate(:comment, album: album)

    params = { body: 'this comment is soo cool'}
    patch "/api/v1/albums/#{album.id}/comments/#{comment.id}.json?api_token=#{SecureRandom.hex}", params.to_json, { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    comment_response = JSON.parse(response.body)

    expect(response.status).to eq(403)
  end
end
