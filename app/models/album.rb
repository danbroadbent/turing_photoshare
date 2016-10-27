class Album < ApplicationRecord
  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :album_users, dependent: :destroy
  has_many :users, through: :album_users

  scope :active, -> { joins(:album_users).merge(AlbumUser.owned_active) }


  def private?
    !self.public
  end

  def self.find_all_public
    left_outer_joins(:users).where("users.active = true").where(public: true)
  end

  def display_users
    users.joins(:user_profile).pluck(:username)
  end

  def permitted?(user)
    # user.active_albums.include?(self)
    users.include?(user)# && users.where("album_users.owner = true").first.active
  end

  def permissions
    public ? "Public" : "Private"
  end
end
