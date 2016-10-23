class Api::V1::CommentsController < ApplicationController
  def index
    if User.find_by(api_token: params[:api_token])
      render json: Comment.all
    else
      render :json => {:error => 'not-found'}.to_json, :status => 404
    end
  end
end
