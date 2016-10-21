class CommentsController < ApplicationController
  def create
    @album = Album.find(params[:album_id])
    @comment = @album.comments.create(comment_params)
    @comment.user_id = current_user.id
    

      @comment.save
      redirect_to album_path(@album)
    # else
    #   flash.now[:danger] = "error posting comment"
    # end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end
end
