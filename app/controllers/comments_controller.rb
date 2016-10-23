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

  def destroy
    # binding.pry
    @album = Album.find(params[:album_id])

    @album.comments.delete(params[:id])

    redirect_to album_path(@album)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :album_id)
  end
end
