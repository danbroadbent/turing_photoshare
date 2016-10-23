class User < ApplicationRecord
  has_secure_password

  has_many :album_users
  has_many :albums, through: :album_users
  has_many :photos
  has_one :user_profile

  enum role: %w(registered admin)
  before_validation :set_role

  extend Forwardable

  def_delegators :user_profile, :username, :phone_number

  def self.find_by_username(username)
    find(UserProfile.find_by(username: username).user_id)
  end

  def set_role
    self.role ||= 0
  end

  def admin?
    self.role == "admin"
  end

  def registered?
    self.role == "registered"
  end
end
