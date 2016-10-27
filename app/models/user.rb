class User < ApplicationRecord
  has_secure_password

  has_many :album_users
  has_many :albums, through: :album_users
  has_many :photos
  has_one :user_profile

  enum role: %w(registered admin)
  before_validation :set_role

  extend Forwardable

  def_delegators :user_profile, :username, :phone_number, :email

  scope :active, -> { where(active: true) }

  def self.find_by_username(username)
    profile = UserProfile.find_by(username: username) || UserProfile.new
    profile.user || User.new
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

  def inactive?
    !active
  end

  def status
    active ? "Active" : "Inactive"
  end

  def active_albums
    Album.joins(:users)
      .where("users.active = true and album_users.owner = true") &
      Album.joins(:album_users)
      .where("album_users.user_id = ?", self.id)
  end
end
