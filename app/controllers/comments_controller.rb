class CommentsController < ApplicationController
  def create
    @album = Album.find(params[:album_id])
    @comment = @album.comments.create(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to album_path(@album)
  end

  def destroy
    @album = Album.find(params[:album_id])
    @album.comments.delete(params[:comment_id])
    redirect_to album_path(@album)
  end

  def edit
    @album = Album.find(params[:album_id])
    @comment = @album.comments.find(params[:id])
  end

  def update
    @album = Album.find(params[:album_id])
    @comment = @album.comments.find(params[:id])
    @comment.update(comment_params)
    redirect_to album_path(@album)
  end



  private
    def comment_params
      params.require(:comment).permit(:body, :user_id, :album_id)
    end
end
