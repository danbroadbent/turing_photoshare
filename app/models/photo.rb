class Photo < ApplicationRecord
  belongs_to :album
  belongs_to :user
  mount_uploader :image, ImageUploader
end
