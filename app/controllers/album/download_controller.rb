class Album::DownloadController < ApplicationController
  def index
    album = Album.find(params[:album])
    photos = album.photos
    compressed_filestream = ZipService.send_zip(album, photos)
    compressed_filestream.rewind
    send_data compressed_filestream.read, filename: "#{album.title}.zip"
  end
end
