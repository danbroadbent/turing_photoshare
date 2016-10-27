class PhotosController < ApplicationController
  def new
    @photo = Photo.new
  end

  def create
    GoogleStorageService.upload_photo(params)
    @photo = Photo.new
    @photo.album_id = params[:photo][:album_id]
    @photo.caption = params[:photo][:caption]
    @photo.image = params[:photo][:image]
    @photo.user_id = current_user.id
    @photo.save
    flash[:success] = "Your photo has been uploaded."
    redirect_to album_path(@photo.album)
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    @album = @photo.album
    @photo.update(photo_params)
    redirect_to album_path(@album)
  end

  def destroy
    @photo = Photo.find(params[:id])
    @album = @photo.album
    @photo.destroy
    redirect_to album_path(@album)
  end


  private
    def photo_params
      params.require(:photo).permit(:caption)
    end
end
