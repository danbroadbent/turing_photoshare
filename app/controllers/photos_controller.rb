class PhotosController < ApplicationController
  def new
    @photo = Photo.new
  end

  def create
    gcloud = Google::Cloud.new(ENV['GOOGLE_CLOUD_KEYFILE_JSON'])
    storage = gcloud.storage
    bucket = storage.bucket 'turing-photoshare'
    file_url = params["photo"]["image"].tempfile.path

    bucket.create_file file_url, Time.now.getutc.to_s

    @photo = Photo.new
    @photo.album_id = params[:photo][:album_id]
    @photo.caption = params[:photo][:caption]
    @photo.image = params[:photo][:image]
# change this after authorization
    @photo.user_id = current_user.id #? current_user.id : User.last.id
    @photo.save!
    redirect_to album_path(@photo.album)
    # else
    #   redirect_to root
    # end

  end

  def destroy
    @photo = Photo.find(params[:id])
    @album = @photo.album
    @photo.destroy
    redirect_to album_path(@album)
  end


  private

    # def photo_params
    #   params.require(:photo).permit(:image, :caption, :album_id, :user_id)
    # end
end
