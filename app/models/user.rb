class User < ApplicationRecord

  has_secure_password

  has_many :albums
  has_many :photos
  has_one :user_profile

  extend Forwardable

  def_delegators :user_profile, :username, :phone_number

  def self.find_by_username(username)
    find(UserProfile.find_by(username: username).user_id)
  end
end
