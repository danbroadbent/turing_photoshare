class Album < ApplicationRecord
  has_many :photos
  has_many :comments
  has_many :album_users
  has_many :users, through: :album_users

  def private?
    !self.public
  end

  def self.find_all_public
    where(public: true)
  end

  def display_users
    users.joins(:user_profile).pluck(:username)
  end

  def permitted?(user)
    users.include?(user)
  end
end
