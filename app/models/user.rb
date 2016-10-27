class User < ApplicationRecord
  has_secure_password

  has_many :album_users
  has_many :albums, through: :album_users
  has_many :photos
  has_one :user_profile
  has_many :comments

  before_destroy :get_ready_to_destroy

  enum role: %w(registered admin)
  before_validation :set_role

  extend Forwardable

  def_delegators :user_profile, :username, :phone_number, :email

  def self.find_by_username(username)
    profile = UserProfile.find_by(username: username) || UserProfile.new
    profile.user || User.new
  end

  def set_role
    self.role ||= 0
  end

  def inactive?
    !active
  end

  def status
    active ? "Active" : "Inactive"
  end

  private

    def get_ready_to_destroy
      albums.joins(:album_users).where("album_users.owner = true").destroy_all
      album_users.destroy_all
      comments.destroy_all
      photos.destroy_all
      user_profile.destroy
    end
end
