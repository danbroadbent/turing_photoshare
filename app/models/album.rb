class Album < ApplicationRecord
  has_many :photos
  has_many :comments
  belongs_to :user

  def private?
    !self.public
  end
end
