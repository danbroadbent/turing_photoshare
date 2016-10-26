class Album::DownloadController < ApplicationController
  def index
    album = Album.find(params[:album])
    photos = album.photos

    compressed_filestream = Zip::OutputStream.write_buffer do |zos|
      photos.each do |photo|
        gcloud = Google::Cloud.new(ENV['GOOGLE_CLOUD_KEYFILE_JSON'])
        file = gcloud.storage.bucket('turing-photoshare').file photo.image.path
        file.download "#{photo.image.path}"
        photo_file = File.open(photo.image.path, "r")
        contents = photo_file.read
        zos.put_next_entry photo.image.path.split('/').last
        zos.print contents
      end
    end

    compressed_filestream.rewind
    send_data compressed_filestream.read, filename: "#{album.title}.zip"
  end
end
