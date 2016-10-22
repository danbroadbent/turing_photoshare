class User < ApplicationRecord
  has_many :albums
  has_many :photos

  has_secure_password

  enum role: %w(registered admin)
  before_validation :set_role

  validates :username, presence: true, uniqueness: true

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
