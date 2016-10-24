class Api::V1::CommentsController < ApplicationController
  def index
    if api_user && api_album.permitted?(api_user)
      render json: Album.find(params[:album_id]).comments.all
    else
      render :json => {:error => 'forbidden'}.to_json, :status => 403
    end
  end

  def show
    if api_user && api_album.permitted?(api_user)
      render json: Comment.find(params[:id])
    else
      render :json => {:error => 'forbidden'}.to_json, :status => 403
    end
  end

  private
  def api_user
    User.find_by(api_token: params[:api_token])
  end

  def api_album
    Album.find(params[:album_id])
  end
end
