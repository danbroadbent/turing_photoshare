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
    # @photo.user_id = User.find(session[:id]).id
    @photo.caption = params[:photo][:caption]
    @photo.image = params[:photo][:image]
    # @photo.user_id = current_user.id
    @photo.save!
      redirect_to album_path(@photo.album)
    # else
    #   redirect_to root
    # end

  end

  private

    # def photo_params
    #   params.require(:photo).permit(:image, :caption, :album_id)
    # end
end
