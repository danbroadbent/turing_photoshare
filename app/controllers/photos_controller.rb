class PhotosController < ApplicationController
  def new
    @photo = Photo.new(photo_params)
  end
end
