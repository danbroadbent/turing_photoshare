class PhotosController < ApplicationController
  def new
    # binding.pry
    @photo = Photo.new
  end

  def create
    gcloud = Google::Cloud.new 'turing-photoshare-146920'
    storage = gcloud.storage
    bucket = storage.bucket 'turing-photoshare'
    file_url = params["photo"]["image"].tempfile.path

    bucket.create_file file_url, Time.now.getutc.to_s

    @photo = Photo.new(photo_params)
    # @photo.user_id = current_user.id
    if @photo.save
      redirect_to album_path(@photo.album)
    else
      binding.pry
      redirect_to root
    end

  end

  private

    def photo_params
      params.require(:photo).permit(:image, :caption, :album_id)
    end
end
