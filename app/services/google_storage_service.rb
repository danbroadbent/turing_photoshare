module GoogleStorageService
  def self.upload_photo(params)
    gcloud = Google::Cloud.new(ENV['GOOGLE_CLOUD_KEYFILE_JSON'])
    storage = gcloud.storage
    bucket = storage.bucket 'turing-photoshare'
    file_url = params["photo"]["image"].tempfile.path

    bucket.create_file file_url, Time.now.getutc.to_s
  end
end
